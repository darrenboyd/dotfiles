# Decent MRI GC settings for faster local development/test (also for tests
# that agents and editors run, so this lives in profile.d).
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000
