ROOT=${PWD}
pip install --upgrade pip

# Basic dependencies
pip install numpy
pip install func-timeout
pip install tqdm
pip install textwrap
pip install psutil
pip install tiktoken
pip install tree-sitter==0.21.3
pip install nvitop

# To generate code, use need additional packages:
# pip install flash-attn --no-build-isolation

# To use [snowflake-artic-instruct](https://huggingface.co/Snowflake/snowflake-arctic-instruct), please install vllm [here](https://docs.google.com/document/d/1SDv-HpXtgWPGCPOksmqhRiO1fkYAYkRpjy84Lj89DdU/edit).
pip install git+https://github.com/Snowflake-Labs/transformers.git@arctic
# This removes undefined DeepSpeed.linear error for yak
# pip install deepspeed
pip install git+https://github.com/Snowflake-Labs/DeepSpeed.git@jrasley/align-lora-weights

# To save s3 checkpoints to local, you need aws
# cd /notebooks
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# mkdir local
# mkdir local/aws-cli
# mkdir local/bin
# ./aws/install -i /notebooks/local/aws-cli -b /notebooks/local/bin

# Download yak2c
# export AWS_ROLE_ARN=arn:aws:iam::294595136076:role/k8s-ml-prod-read-s3-role-sfc-or-dev-misc-k8s-ml5
# mkdir yak2c
# /notebooks/local/bin/aws s3 sync s3://ml-dev-sfc-or-dev-misc1-k8s/yak/yak-instruct/yak2c-small-instruct-v44/2024.05.12-03.05.36/converted_global_step3194/ yak2c

# cd submodules
# git clone -b arctic https://github.com/Snowflake-Labs/vllm.git
#pip install git+https://github.com/Snowflake-Labs/vllm.git@arctic
cd ${ROOT}/submodules/vllm/examples
# Make sure the yak_model_path points to the folder path we provided.
python offline_inference_arctic.py 2>&1 | tee -a offline_inference_arctic.log

cd ../..
