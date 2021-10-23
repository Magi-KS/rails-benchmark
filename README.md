# Rails Benchmark

This repository is created to test rails "performance" out of the box with 2 different application server [unicorn](https://github.com/defunkt/unicorn) and [puma](https://github.com/puma/puma)

There are 2 kind of workload that is being tested here, one is without IO and another with IO

# Requirements

[docker](https://www.docker.com/)

# How to use

## Build the image

In this repository run:
```bash
docker build -f rails-docker -t magi-ks-rails-benchmark .
```

## Start the rails instances
starting the Puma instance:
```bash
docker run -p 8080:3000 --cpus 1 --cpuset-cpus 4 -e RAILS_ENV=production magi-ks-rails-benchmark bundle exec rails s -b 0.0.0.0
```

### OR

starting the Unicorn instance:
```bash
docker run -p 8080:3000 --cpus 1 --cpuset-cpus 4 -e RAILS_ENV=production magi-ks-rails-benchmark bundle exec unicorn
```

## Hit the instance with load testing tool
You can use whatever you like but I found [Plow](https://github.com/six-ddc/plow) to be decent.

### Testing the endpoint without IO workload
```bash
docker run --rm --net=host ghcr.io/six-ddc/plow -c 1 'http://localhost:8080/'
```

### Testing the endpoint with simulated IO workload
```bash
docker run --rm --net=host ghcr.io/six-ddc/plow -c 1 'http://localhost:8080/simulated_io?delay=1'
```

### Things to tweak

at the `simulated_io` you can specify the amount of seconds of `delay` the simulated IO is gonna take before it returns a response.

### Example result
```bash
Benchmarking http://localhost:8080/ using 1 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed     6.134s
  Count         5962
    2xx         5962
  RPS        971.808
  Reads    0.456MB/s
  Writes   0.054MB/s

Statistics   Min     Mean    StdDev    Max
  Latency   775µs   1.024ms  248µs   8.265ms
  RPS       950.24  975.12   20.67   995.55

Latency Percentile:
  P50      P75      P90      P95     P99     P99.9   P99.99
  974µs  1.073ms  1.227ms  1.423ms  2.04ms  2.927ms  8.265ms

Latency Histogram:
  933µs    3915  65.67%
  1.062ms  1289  21.62%
  1.292ms   543   9.11%
  1.612ms   140   2.35%
  1.939ms    42   0.70%
  2.092ms    15   0.25%
  2.302ms    12   0.20%
  2.748ms     6   0.10%
```
