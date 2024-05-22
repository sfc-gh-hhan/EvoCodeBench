ROOT=${PWD}

# task: baseline | local_completion | local_infilling
#tasks=(local_infilling local_completion baseline)
tasks=(local_infilling)
models=(yak2c deepseek-7b)
decode=greedy
n_gpus=2

for task in ${tasks[@]}; do
    for model in ${models[@]}; do
        echo "Running inference for $task $model"
        python LM_inference.py \
            --setting $task \
            --output_dir ${ROOT}/model_completion/${task}/${model}_${decode}/raw \
            --model $model \
            --moda $decode \
            --tensor_parallel_size ${n_gpus} \


        cd prompt
        python process_completion.py \
            --model_type lm \
            --completion_file ${ROOT}/model_completion/${task}/${model}_${decode}/raw/completion.jsonl \
            --output_file ${ROOT}/model_completion/${task}/${model}_${decode}/my_completion.jsonl \
            --data_file ${ROOT}/data.jsonl
        cd ..
    done
done