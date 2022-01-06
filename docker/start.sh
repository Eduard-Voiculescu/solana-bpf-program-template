# Compile code
cd ./solana-bpf-program-template && cargo build-bpf

# Create and save a solana keypair locally
solana-keygen new

# Set solana config url
solana config set --url http://127.0.0.1:8899

# Run solana-test-validator in the background and put the stdout in the /dev/null
solana-test-validator > /dev/null 2>&1 &

# Deploy program
solana program deploy /home/root/solana-bpf-program-template/target/deploy/bpf_program_template.so
