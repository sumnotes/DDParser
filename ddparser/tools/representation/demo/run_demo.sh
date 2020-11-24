set -eux

export FLAGS_eager_delete_tensor_gb=0
export FLAGS_sync_nccl_allreduce=1
export CUDA_VISIBLE_DEVICES=0

MODEL_PATH="ernie1.0base"
TASK_DATA_PATH="LCQMC"


python -u ./ERNIE/run_classifier.py \
                   --use_cuda true \
                   --verbose true \
                   --do_train true \
                   --do_val true \
                   --do_test false \
                   --batch_size 64 \
                   --init_pretraining_params ${MODEL_PATH}/params \
                   --train_set ${TASK_DATA_PATH}/train_ddp.csv \
                   --dev_set ${TASK_DATA_PATH}/dev_ddp.csv,${TASK_DATA_PATH}/test_ddp.csv \
                   --vocab_path ${MODEL_PATH}/vocab.txt \
                   --checkpoints ./checkpoints \
                   --save_steps 1000 \
                   --weight_decay  0.0 \
                   --warmup_proportion 0.0 \
                   --validation_steps 100 \
                   --epoch 3 \
                   --max_seq_len 128 \
                   --ernie_config_path ${MODEL_PATH}/ernie_config.json \
                   --learning_rate 2e-5 \
                   --skip_steps 10 \
                   --num_iteration_per_drop_scope 1 \
                   --num_labels 2 \
                   --random_seed 1 \
                   --metric acc_and_f1 