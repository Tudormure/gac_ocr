# OCR in MATLAB
Before run: Right-Click on functii folder -> Add to path -> Selected Folder(s) and Subfolders

## 1. Train parameters steps (all commands must be run in console)
1.  To generate inputs in workspace: **[X_train,Y_train,X_test,Y_test] = gen_in;** , ";" included.Variable names can differ from the command, but they must be unique.
2.  To train parameters from nothing: **train(X_test,Y_test,X_train,Y_train)**     . Variable names must correspond with step 1. 
3.  To load the downloaded parameter in the workspace, double-click on "params_97.63" .
4.  To resart the training process from already calculated parameters: **train(X_test,Y_test,X_train,Y_train,parameters)**.

## 2. Run GUI
1.  Load parameters by double-clicking on them, or generate and train them.
2.  **gui(parameters)** to run the GUI.
   
