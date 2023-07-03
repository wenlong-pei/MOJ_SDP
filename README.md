# Multi-objective-Just-in-time-Software-Defect-Prediction


Boosting Multi-objective Just-in-time Software Defect Prediction by Fusing Expert Metrics and Semantic Metrics




Dataset
========
This study used 21 Java projects from the large-scale high-quality data set recently collected by Ni et al. to mitigate the impact of tangled commits on the basis of LLTC4J.The details of statistical information  can be found in Table as bellow.
![image](https://user-images.githubusercontent.com/28954173/208236564-e8f2a321-0cdc-4672-baaa-f518ca1c603a.png)

Baseline
=============

We have provided some baseline running scripts here. Please use the following command to obtain the results of these baselines:

- **LApredict**

  ```python
   python -m baselines.LApredict.lapredict
  ```

- **Yan et al**

  First, run code in `n_gram.java` and then run the following command:

  ```python
   python -m baselines.ngram.evaluate_result
  ```

- **Deeper**

  ```python
   python -m baselines.Deeper.deeper
  ```

- **DeepJIT**

  ```python
    python -m baselines.DeepJIT.deepjit
  ```

- **CC2Vec**

  ```python
    python -m baselines.CC2Vec.cc2vec
  ```

- **JITLine**

  ```python
    python -m baselines.JITLine.jitline -style concat
  ```

- **JIT-Fine**

  ```python
    python -m JITFine.concat.run \
      --output_dir=model/jitfine/saved_models_concat/checkpoints \
      --config_name=microsoft/codebert-base \
      --model_name_or_path=microsoft/codebert-base \
      --tokenizer_name=microsoft/codebert-base \
      --do_test \
      --train_data_file data/jitfine/changes_train.pkl data/jitfine/features_train.pkl \
      --eval_data_file data/jitfine/changes_valid.pkl data/jitfine/features_valid.pkl\
      --test_data_file data/jitfine/changes_test.pkl data/jitfine/features_test.pkl\
      --epoch 50 \
      --max_seq_length 512 \
      --max_msg_length 64 \
      --train_batch_size 256 \
      --eval_batch_size 25 \
      --learning_rate 2e-5 \
      --max_grad_norm 1.0 \
      --evaluate_during_training \
      --only_adds \
      --buggy_line_filepath=data/jitfine/changes_complete_buggy_line_level.pkl \
      --seed 42 2>&1 | tee model/jitfine/saved_models_concat/test.log
  ```

  
Result
=============

![image](https://user-images.githubusercontent.com/28954173/208235311-e7d462f7-622b-4246-983f-86ca3c5568fb.png)


![image](https://user-images.githubusercontent.com/28954173/208236627-c1f9dd4e-2d11-424e-a765-ce242f3f337e.png)


![image](https://user-images.githubusercontent.com/28954173/208235346-13bb4e99-0b8d-4b89-b92d-7f3229cf4584.png)

CodeBERT Parameter Setting
===================
Learning rate=1e-5

batch size=24

maxmium epoch=50

Operation Guide
===================
Train the MOJ-SDP model based on expert metrics：<br>
_________
    Use only the first 14 columns in the dataset.Change the size of matrix A in ..\MODEP\fitnessLogistic_nclasses.m and ..\Project\muti_testLogistic_nclasses.m,and change the variable 'nvar' in ..\MODEP\MODEP.m to 14.

Train the MOJ-SDP model based on semantic metrics：<br>
__________
    Use only the last 768 columns in the dataset.Change the size of matrix A in ..\MODEP\fitnessLogistic_nclasses.m and ..\Project\muti_testLogistic_nclasses.m,and change the variable 'nvar' in ..\MODEP\MODEP.m to 768.

Train the MOJ-SDP model based on fusion metrics：<br>
__________
    Use only the last 782 columns in the dataset.Change the size of matrix A in ..\MODEP\fitnessLogistic_nclasses.m and ..\Project\muti_testLogistic_nclasses.m,and change the variable 'nvar' in ..\MODEP\MODEP.m to 782.

Model complementary analysis, run<br>
____________
    venn\demo1.m

Model performance evaluation, run<br>
____________
    Bar_chart.m

Environment
===================
Intel(R) Core(TM) i5-10200H CPU @ 2.40GHz   2.40 GHz

MATLAB R2018b
