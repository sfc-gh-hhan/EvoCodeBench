cd ..
ROOT=${PWD}
cd parser

Source_Code_Root=$ROOT/Source_Code
Dependency_Root=$ROOT/Dependency_Data

tasks=(baseline local_completion)
models=(deepseek-7b yak2c)
decode=greedy
is_my=false

if ${is_my} ; then
    is_my="my_"
else
    is_my=""
fi

for task in ${tasks[@]}; do
    for model in ${models[@]}; do
        cd ..
        tar -xzf Source_Code.tar.gz
        cd parser
        echo "Running recall@1 for $task $model_${decode} ${is_my}completion.jsonl"
        python ../check_source_code.py $ROOT/Source_Code
        python recall_k.py \
            --output_file $ROOT/model_completion/$task/${model}_${decode}/${is_my}completion.jsonl \
            --log_file $ROOT/model_completion/$task/${model}_${decode}/${is_my}dependency_results.jsonl \
            --k 1 \
            --source_code_root $Source_Code_Root \
            --dependency_data_root $Dependency_Root \
            --data_file $ROOT/data.jsonl 2>&1 | tee -a $ROOT/model_completion/$task/${model}_${decode}/${is_my}dependency_recall_at_k.log
    done
done