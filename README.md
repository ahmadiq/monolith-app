# monolith


## Scaling

We can configure scaling of our application using the following means:
1. Horizontal Pod Autoscaling: 
  We can configure our pod replicas to scale based on metrics usually for resource consumption such as cpu and memory 
  utilization, or also custom metrics if they have been so defined.
  When the configured resource utilization thresholds are met, kubernetes will add new replicas which will be able to
  handle the additional incoming requests.
  
2. KEDA: This is another tool which can be used for autoscaling of pod replicas. With KEDA we can specify the scaling trigger
   based on the types of request, for example we can configure scaling based on for requests of type http going to a specific port or path, etc.

3. Cluster autoscaler: The Cluster autoscaler is also a useful tool to ensure that the kubernetes cluster we have created
   is not under or over-utilized. We don't need to add nodes incurring unnecessary costs in our cluster 
   which we expect may only be used some of the times, for example peak usage times. The Cluster Autoscaler allows us to
   scale our cluster nodes on which more pod replicas can then be scheduled allowing the application to serve more requests.

4. Vertical Pod autoscaler is also another tool that can be used, however the drawbacks are that it will recreate pods to  
   update their resource limits, and this can be especially problematic if the traffic is more spikey rather than having
   a slower rate of change.
