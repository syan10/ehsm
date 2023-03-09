cov-configure --gcc
cov-configure  --template --compiler CC  --comptype gcc
cov-configure  --template --compiler CXX  --comptype g++


cov-build --dir ~/code/sp-ehsm/coverity/ make clean
cov-build --dir ~/code/sp-ehsm/coverity/ make
