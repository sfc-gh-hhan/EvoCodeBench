ROOT=${PWD}

# task: baseline | local_completion | local_infilling
#tasks=(local_infilling local_completion baseline)
tasks=(baseline)
models=(deepseek-7b)
decode=greedy

for task in ${tasks[@]}; do
    for model in ${models[@]}; do
        echo "Running pass@1 for $task $model"
        python LM_inference.py \
            --setting $task \
            --output_dir ${ROOT}/model_completion/${task}/${model}_${decode}/raw \
            --model $model \
            --moda $decode \


        cd prompt
        python process_completion.py \
            --model_type lm \
            --completion_file ${ROOT}/model_completion/${task}/${model}_${decode}/raw/completion.jsonl \
            --output_file ${ROOT}/model_completion/${task}/${model}_${decode}/my_completion.jsonl \
            --data_file ${ROOT}/data.jsonl
    done
done