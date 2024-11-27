vault server -dev -config /config.hcl &
VAULT_PID=$!

# Wait until Vault is unsealed
until vault status -non-interactive &>/dev/null; do
  sleep 0.5
done

# Start filesystem watchers
fsnotifywait -SmrFco /out/vault-fs-events.txt /scratch &
FSNWAIT_PID=$!
fsnotifywatch -SrF /scratch > /out/vault-fs-events-summary.txt &
FSNWATCH_PID=$!

# Forward SIGINT and SIGTERM to all children but ignore those signals ourselves
trap "trap '' SIGINT SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Run the benchmark!
VAULT_TOKEN=root vault-benchmark run -config=/bench.hcl -duration=5m -report_mode=json -audit_path=/out/vault-audit.json | tee /out/bench-results.json

# Save IO stats of the Vault process
cp /proc/$VAULT_PID/io /out/vault-io-stats.txt

# Stop file watchers
kill $FSNWAIT_PID
kill $FSNWATCH_PID

# Stop Vault
kill $VAULT_PID

wait

# All processes should be dead, disarm traps
trap - SIGINT SIGTERM EXIT

# Generate a terse summary of the benchmark results
vault-benchmark review -results_file=/out/bench-results.json | tee /out/bench-results-terse.txt