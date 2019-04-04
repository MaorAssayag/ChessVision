<img src="https://github.com/MaorAssayag/ChessVision/blob/master/screenshot3.PNG" width="170">  

# Chess Vision
## Image Processing in MATLAB with microframework in Python

## Abstract
#### Throughout history chess has fascinated millions of people around the world with the complexity it presents, not only as a hobby but also as an opportunity to demonstrate creativity and improve calculated decision-making. 

#### Over the years, the task of electronically tracking a game of chess has been undertaken by many people. A digital chess set can easily record a game automatically, but the specialized chessboard and pieces can be costly.  

#### While more technically challenging, the use of image processing to detect and identify a chessboard and the configuration of its pieces avoids the need for a digital chess set. Furthermore, image-based detection of chess pieces is a vital step in building chess-playing physical machines. Such machines can be used for fun or research and have been considered as an interactive toy that helps in developing the learning abilities of chess.   

#### A goal of this project is responsive identification of both the board and pieces using image processing. This research's [1] [2] and many more provide some applicable approaches to identifying 3D chess pieces using Convolutional Neural Network (CNN) - due to insufficient results from more robust image-processing algorithm (e.g. SURF/SIFT). 

#### For the goal of using those image-processing tools, the using of 3D pieces was ruled out. We decided to approach the piece identification part of the problem by using 2D pieces, which is widely used for learning chess.  

#### In addition to tracking the state of a chess game, the system will provide a visual presentation of the legality of the move played and suggestion for the best next move using a chess engine.  

#### This project contains several steps involving image-processing tools such as transformations, color spaces, segmentations etc.'   

#### Keywords: chess, image-processing, SURF, transformation, classification, hand-recognition  

## Development frameworks
<img src="https://github.com/MaorAssayag/ChessVision/blob/master/screenshot2.PNG" width="500">  

#### The image processing part (hand gestures recognition, chessboard segmentation, chess pieces classification and calibration logic) is done using MATLAB R2018 with the image-processing tool-kit.  

#### The MATLAB code is communicating with a Python code via a text-based communication (read & write from several text files). In general, the MATLAB side is responsible for delivering the detected move done by the player.   

#### The state of the chess game is mainly tracked by the Python side, which consist of multithreaded code that handle a microframework (web app server for visualization) thread & chess game tracking with best move suggesting feedback (and legality flags etc.') thread.   

#### The microframework is designed using FLASK web with SocketIO which gives the Flask web application access to low latency bi-directional communications between the clients and the server – that enables us to update the local webpage with the current state of the games & mandatory visualization for the user (using jQuery that updates the HTML code of the web page).  

## Microframework & Chess engine communication
<img src="https://github.com/MaorAssayag/ChessVision/blob/master/screenshot4.png" width="800">  

#### To connect an analysis of a chess engine, we need to be able to use an UCI communication protocol. In addition, we want to be able to maintain a User Interface that will be interactive and simple for providing feedback on the concurrent game played.  

#### Our approach is to maintain a microframework (simple web app) locally, communicate with the image-processing part (MATLAB) with text-file read\write based communication & tracking the chess game in Python with the help of the chess-python library. We made changes to the free open source library to fill our need best, which we will elaborate later.   

#### The python code handles communicating with the chess engine, maintaining a web app with chessboard rendering, best-move suggestion and legality feedback.  

## Results
<img src="https://github.com/MaorAssayag/ChessVision/blob/master/screenshot5.png" width="600">  

#### Our team felt great success at the presentation day at the project day event. We have been chosen as the second favorite project by visitors QR-voting, and the system didn't fail to surprise mentors, friends and even people who don't know chess or played slightly too-aggressively with the pieces (still accuracy was shown).  

#### The algorithm flow found to be very fast and responsive (if there is a delay in some part, is a delay we put for safety measures or best accuracy, for e.g. how much time we give the engine to think and give us a move suggestion).  

#### We gained approximal 100% accuracy in the hand recognition part (determine the chess-engine skill level), 93% accuracy on piece classification, 100% on empty classification and the most important number – after all the logic layers we didn't encounter any issue with detecting the right move that was played.  

## Conclusions remarks  

#### This project gave us amazing opportunity to demonstrate creativity using the image-processing tools we learnt at class & assignments. In addition, we got to work with multi-platform code, communication protocols, microframework design, classification and much more.  

#### Although we feel that we achieved any pre-set goal that we have, there is always room to improvements, especially if we are thinking about generalize the chess pieces. Future work can be done to implementing ideas from research's papers about classification of 3D chess pieces (not just with the image-processing tools that we learned, and even considering deep-learning for better results).  

#### In the end, we are very proud in the project and the code we wrote. The microframework part can actually be use by anyone who wants a working tool to communicate with a chess engine & have a simple UI to show the results live.  

#
<img src="https://github.com/MaorAssayag/ChessVision/blob/master/screenshot.PNG" width="300">   

#### Full Description in English - <a href="https://github.com/MaorAssayag/ChessVision/blob/master/Chess%20Vision.pdf">link</a>

#### Video on YouTube - <a href="https://www.youtube.com/watch?v=OCpOOs74qFg">link</a>

#
### Authors
*Maor Assayag*  
Computer Engineer, Ben-gurion University, Israel

*Refhael Shetrit*  
Computer Engineer, Ben-gurion University, Israel

*Eyal Zuckerman*  
Electrical Engineer, Ben-gurion University, Israel

*Yaniv Okavi*  
Electrical Engineer, Ben-gurion University, Israel
