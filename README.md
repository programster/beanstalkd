Beanstalkd + Docker
=================
This project allows you to easily deploy a Beanstalkd queue with the help of [Docker](https://www.docker.com/). Data will persist between starting and stopping containers through the use of a Docker Volume (`data` folder).

## Steps
* Clone this repo with `git clone https://github.com/programster/beanstalkd.git`
* Look in the `Settings.sh` file and change any settings you desire (read the comments)
* Build the container by running `bash BuildContainer.sh`
* Run the container by running `bash RunContainer.sh`

## Caveats
* This project is configured such that only one instance of the container will run. Calling `RunContainer.sh` twice will result in the first container to be killed before the next is spawned.
* The queue is only synced to the data volume at a maximum rate of once per minute, which you may wish to change (last line in the Dockerfile).
