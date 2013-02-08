worker_processes 3

listen 5000
listen 5001
listen 5002

preload_app true

timeout 30

pid               '/home/ubuntu/midiaexterna/shared/pids/unicorn.pid'
stderr_path       '/home/ubuntu/midiaexterna/shared/log/unicorn.error.log'
stdout_path       '/home/ubuntu/midiaexterna/shared/log/unicorn.out.log'
working_directory '/home/ubuntu/midiaexterna/current'