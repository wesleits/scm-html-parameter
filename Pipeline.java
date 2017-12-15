pipeline 
{
  agent 
  {
    label 'master'
  }
  options 
  {
    skipDefaultCheckout true
  }
  stages 
  {
    stage('Define Variables') 
    {
      steps 
      {
        script 
        {
          REGION = "us-east-1"
          CLUSTER_NAME = "dev1"
        }
      }
    }
    stage('Tests') 
    {
      steps 
      {
        script 
        {
          println REGION
        }
      }
    }
  }
}