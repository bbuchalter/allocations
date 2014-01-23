# What is this?
This is a Rails application that plugs into Rails instrumentation to trace object allocation during the lifecycle of a request.
The trace data will be streamed to your browser and graphed real time in D3.
Keep in mind this is a proof of concept!

# Why does this exist?
This is just a simple rails application right now, but the goal is to make it a mountable rails engine. 
Doing so will enable real time allocation profiling of YOUR rails application.

## Recommended:
1. Ruby 2.1
1. Lots of RAM

## Setup:
1. ```ruby bundle install```
1. ```ruby rails s```

## What do I do?
1. Load ```http://localhost:3000```
1. Click 'Start instrumentation'
