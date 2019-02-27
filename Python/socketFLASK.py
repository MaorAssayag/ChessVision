from flask_socketio import SocketIO, emit
from flask import Flask, render_template, url_for, copy_current_request_context
from random import random
from time import sleep
from threading import Thread, Event
import chess
import chess.uci
import chess.svg
import sys

# Initialize
file_to_read = "RecMoves.txt"
file_engine_level = "EngineLevel.txt"
file_to_write = "EngineMoves.txt"
file_fen = "FEN.txt"
file_reset = "Reset.txt"
engine_path = r"C:\Users\MaorA\Desktop\projectImage\stockfish-10-win\Windows\stockfish_10_x32"
currentBestMove = ""
currentNumOfMoves = 0
oldIllegelMove = 0
board_html_size = 550
engine = 0
svg_code = 0
handler = 0
board = 0
delay = 0.5
intial_fen = 0
gray_color = "#d3d3d3"
red_color = "#e50000"
gold_color = "#FFD700"
flag_illegalmove = 0
flag_connected = 0
flag_engine_answer = 0

# Set your evaluation time, in ms:
evaltime = 300  # so 0.3 seconds
skill_level = 15  # default Skill Level 0-20

def initalize():
    global engine, currentBestMove, currentNumOfMoves, svg_code, handler, file_to_read, file_to_write, board, intial_fenm, file_fen, oldIllegelMove, flag_connected

    # Delete old file content
    open(file_to_read, 'w').close()
    open(file_to_write, 'w').close()
    open(file_fen, 'w').close()
    open(file_engine_level, 'w').close()

    flag_connected = 1
    currentBestMove = ""
    currentNumOfMoves = 0
    oldIllegelMove = 0

    # Read engine level detected
    i = 0
    array = []
    while (not thread_stop_event.isSet() and sum(1 for line in open(file_engine_level, "r")) < 1):
        sleep(delay)
    with open(file_engine_level, "r") as ins:
        for line in ins:
            i = i + 1
            array.append(line)
    skill_level = int(array[i - 1].rstrip())

    # Check for Illegel skill_level
    if (skill_level > 20 or skill_level < 0):
        skill_level = 15
    socketio.emit('enginelevel', {'level': skill_level}, namespace='/test')

    # Now we have our board ready, load stockfish 10 engine:
    handler = chess.uci.InfoHandler()
    engine = chess.uci.popen_engine(engine_path)  # give correct address of your engine here
    engine.setoption({"Skill Level": skill_level})
    engine.info_handlers.append(handler)

    # Read starting position detected using image processing(MATLAB) - FEN string
    i = 0
    array = []
    while (not thread_stop_event.isSet() and sum(1 for line in open(file_fen, "r")) < 1):
        sleep(delay)
    sleep(0.05)
    with open(file_fen, "r") as ins:
        for line in ins:
            i = i + 1
            array.append(line)
    intial_fen = array[0].rstrip()

    # Generate first board state & update the web app
    # chess Board
    board = chess.Board(fen = intial_fen)

    # Check for invalid starting FEN position
    while (not board.is_valid()):
        svg_code = chess.svg.board(board=board, size=board_html_size)
        # Update webpage with the new board & without a sound (initial board position)
        socketio.emit('newmove',{'board': svg_code}, namespace='/test')
        socketio.emit('illegalmove', {'color': red_color}, namespace='/test')
        print(board.status())
        m = open(file_fen, 'a')
        m.write("illegal position" + '\n')
        m.close()
        while (sum(1 for line in open(file_fen, "r")) != 1):
            sleep(delay)
        with open(file_fen, "r") as ins:
            for line in ins:
                i = i + 1
                array.append(line)
        intial_fen = array[i - 1].rstrip()
        board = chess.Board(fen=intial_fen)

    m = open(file_fen, 'a')
    m.write("llegal position" + '\n')
    m.close()
    engine.position(board)
    evaluation = engine.go(movetime=evaltime)
    currentBestMove = str(evaluation[0])
    writeMove()

    # Generate svg view of the updated board
    # If check occure get the square of the king to be highlited
    check_square = board.king_squaree_ifcheck();
    # Check if the intial position is a game that over
    if (not board.is_game_over()):
        svg_code = (chess.svg.board(board=board, arrows=[
            chess.svg.Arrow(getMoveAttribute(currentBestMove, 0), getMoveAttribute(currentBestMove, 1))],
                            check=check_square, size=board_html_size))
    else:
        svg_code = (chess.svg.board(board=board,check=check_square, size=board_html_size))
        final_result = board.result();
        # if the final result is a draw/black won/white won - display it on the web
        if final_result != "*":
            socketio.emit('endgameresult', {'result': final_result, 'color' : gold_color}, namespace='/test')
        thread_stop_event.set()

    # Update webpage with the new board & without a sound (initial board position)
    socketio.emit('newmove', {'board': svg_code}, namespace='/test')
    socketio.emit('illegalmove', {'color': gray_color}, namespace='/test')


def getMoveAttribute(move_str, square_number):
    """input: move_str = uci move e.g. 'e2e4',square_number : 0/1 for the first/second square"""
    """output: chess.E2 / chess.E4 attribute for drawing arrow on this move"""
    str = move_str[0 + square_number * 2:2 + square_number * 2]
    if (str.upper() != "NO"):
         ans = getattr(chess, str.upper())
    else:
        ans = ""
    return ans

def writeMove():
    """Write the current engine suggestion to the EngineMoves txt file"""
    global currentBestMove
    m = open(file_to_write, 'a')
    m.write(currentBestMove + '\n')
    m.close()
    print(flag_engine_answer)

# Flsak app
__author__ = 'Chess Vision'

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
app.config['DEBUG'] = False

# Turn the flask app into a socketio app
socketio = SocketIO(app)

# Chess game Thread
thread = Thread()
thread_stop_event = Event()

class ChessThread(Thread):
    def __init__(self):
        self.delay = 0.3
        super(ChessThread, self).__init__()

    def gameOn(self):
        global currentNumOfMoves, currentBestMove, svg_code, board, engine, handler, board_html_size, flag_illegalmove, flag_engine_answer

        while (not board.is_game_over()):
            # Get the user move from file RecMoves
            array = []
            # not thread_stop_event.isSet() and
            while (sum(1 for line in open(file_to_read)) == currentNumOfMoves):
                sleep(self.delay)
            if (thread_stop_event.isSet()):
                break
            print(currentNumOfMoves)
            check = open(file_to_read)
            num_lines = sum(1 for line in check)
            currentNumOfMoves = num_lines;
            with open(file_to_read, "r") as ins:
                for line in ins:
                    array.append(line)

            # Create a move object with this move string
            var = array[currentNumOfMoves - 1].rstrip()
            # If the user did wrong castling, detected from image processing (MATLAB)
            # if (((int(var[1]) == 7) and (int(var[3]) == 8)) or ((int(var[1])==2) and (int(var[3])==1))):
            #     print("enter1")
            #     print(board.piece_type_at(var))
            #     current_squre = "BB_" + var[0:2]
            #     print(current_squre.upper())
            #     if board.piece_type_at(mask=current_squre.upper())== "PAWN":
            #         print("enter2")
            #         var = var + 'q'
            # print(var)
            move = chess.Move.from_uci(var)

            # If the move is legal, push it to the board object
            if board.is_legal(move):
                print('llegel move')
                print(move)
                board.push(move)
                # Give your position to the engine
                engine.position(board)
                evaluation = engine.go(movetime=evaltime)
                currentBestMove = str(evaluation[0])
                flag_engine_answer = 0
                # If check occure get the square of the king to be highlited
                check_square = board.king_squaree_ifcheck();

                if (not board.is_game_over()):
                    # Then draw the board with the next best move suggestion arrow
                    svg_code = (chess.svg.board(board=board, arrows=[
                        chess.svg.Arrow(getMoveAttribute(currentBestMove, 0), getMoveAttribute(currentBestMove, 1))],
                                                check=check_square, lastmove=move,size=board_html_size))  # svg code block for the board for html view
                else :
                    # Generate svg view of the updated board without next move suggestion (game ended)
                    svg_code = (chess.svg.board(board=board, check=check_square, lastmove=move, size=board_html_size))  # svg code block for the board for html view

                # Update webpage with the new board & make a new move sound
                socketio.emit('newmove', {'board': svg_code}, namespace='/test')
                socketio.emit('newmove_sound', namespace='/test')

                # There is a llegal move to cancel the previus illegal move
                if (flag_illegalmove == 1):
                    flag_illegalmove = 0
                    socketio.emit('illegalmove', {'color': gray_color}, namespace='/test')

                # Write the best move to EngineMoves text file
                writeMove()
                # Print for debug
                # print(str(evaluation[0]))
                # print best move, evaluation and mainline:
                # print('FEN of the last position of the game: ', board.fen())
                # print('best move: ', board.parse_uci(evaluation[0]))
                # print('best move: ', evaluation[0])
                # print('evaluation value: ', handler.info["score"][1].cp/100.0)
                # print('Corresponding line: ', board.variation_san(handler.info["pv"][1]))
                # print('Corresponding line: ', board.variation(handler.info["pv"][1]))
                # print('Corresponding line: ', handler.info["pv"][1])

            else:
                # if the current move is the oppsite from the last illegel move
                # emit_illegal = True
                # if flag_illegalmove :
                #     old_from = oldIllegelMove[0:2]
                #     old_to = oldIllegelMove[2:4]
                #     current_from = var[0:2]
                #     current_to = var[2:4]
                #     if (old_from == current_to and old_to == current_from) :
                #         emit_illegal = False
                #         socketio.emit('illegalmove', {'color': gray_color}, namespace='/test')
                # if emit_illegal :
                socketio.emit('illegalmove', {'color': red_color}, namespace='/test')
                flag_illegalmove = 1
                print('illegel move')
                print(move)
                currentBestMove = "illegal"
                flag_engine_answer = 0
                writeMove()

        # Exit while - the game is over / the thread stopped
        final_result = board.result();

        # if the final result is a draw/black won/white won - display it on the web
        if final_result != "*":
            socketio.emit('endgameresult', {'result': final_result, 'color' : gold_color}, namespace='/test')

    def run(self):
        initalize()
        socketio.emit('newgame_sound', namespace='/test')
        self.gameOn()

@app.route('/')
def index():
    #only by sending this page first will the client be connected to the socketio instance
    return render_template('index.html')

@socketio.on('connect', namespace='/test')
def connect():
    # need visibility of the global thread object
    global thread, flag_engine_answer
    print('Client connected')
    print("Starting Thread")
    # thread_stop_event.set()
    # sleep(0.2)
    #if (not flag_engine_answer):
    thread_stop_event.clear()
    if (thread != None):
        thread = ChessThread()
        thread.start()
    m = open(file_reset, 'w')
    m.write("reset \n")
    m.close()

@socketio.on('disconnect', namespace='/test')
def disconnect():
    global thread_stop_event
    # thread_stop_event.set()
    print('Client disconnected')

if __name__ == '__main__':
    socketio.run(app)