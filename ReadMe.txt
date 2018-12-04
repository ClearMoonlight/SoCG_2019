1. The folder Data includes two subfolders:
   (1)MNIST has two subfolders
      1>Gray is original dataset (n,d);
      2>JL is dimensionality reduction dataset (n,d/4) and (n,d/8);
   (2)Caltech has three subfolders
      1>Code is the preprocessing code;
      2>VGG is original dataset (n,d);
      3>JL is dimensionality reduction dataset (n,d/4) and (n,d/8).
2. The folder ABOD is the code of the paper "Angle-based outlier detection in high-dimensional data"
published at KDD 2008. Run the files OR_MNIST.m and OR_Caltech.m to execute experiments on MNIST and
Caltech respectively. 
3. The folder OCSVM is the code of the paper "Support vector method for novelty detection" pubslished
at NIPS 1999. Run the files OCSVM_MNIST.m and OCSVM_Caltech.m to execute experiments on MNIST and Cal-
tech respectively. 
4. The folder DRAE is the code of the paper "Learning discriminative reconstructions for unsupervised 
outlier removal" published at ICCV 2015. Run the files MNIST_Gray.m and Caltech_VGG.m to execute expe-
riments on MNIST and Caltech respectively. 
5. The folder Ours is our code:
   (1)MEB has two subfolders
      1>Random is the code for random dataset. Run demo_Ori.m, demo_JL.m and demo_Sample.m to execute
	experiments on the original dataset (n,d), dimensionality reduction dataset (n,d/4) and (n,d/8) 
	and sampling dataset (n/4,d/8), (n/8,d/8) and (n/16,d/8) respectively; 
      2>Real is the code for MNIST and Caltech. Run Ours_MNIST.m, Ours_MNIST_JL.m and Ours_MNIST_Sample.m
	to execute experiments on MNIST for the original dataset (n,d), dimensionality reduction dataset 
	(n,d/4) and (n,d/8) and sampling dataset (n/4,d/8), (n/8,d/8) and (n/16,d/8) respectively. 
	In a similar way, run Ours_Caltech.m, Ours_Caltech_JL.m and Ours_Caltech_Sample.m to execute expe-
        riments on Caltech.