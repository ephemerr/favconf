export JOBID=$(jobs -l | sed -rn '0,/vim/{s|.([[:digit:]]*).* suspended  vim.*|%\1|p}')
echo $JOBID
if [[ $JOBID == "" ]]
then
  vim $@
else
  fg $JOBID
fi
