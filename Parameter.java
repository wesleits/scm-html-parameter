String jobName = (Thread.currentThread().toString() =~ /job\/(.*?)\//)[0][1];


return "oi" + jobName + System.currentTimeMillis()