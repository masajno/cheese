double[][] Qtable = new double[2][2];
int max_a;
double max;
int select_a = 0;

double machine_reward(int s, int a){
  double reward;
  if(s*a==0){
    reward = 0.0;
  }
  else{
    reward = 10.0;
  }
  return reward;
}

int machine_sd(int s, int a){
  int sd;
  if(s==0&&a==0){
    sd = 1;
  }
  else if(s==1&&a==0){
    sd = 0;
  }
  else{
    sd=s;
  }
  return sd;
}

double max_Qval(int s, int num_a, double[][] Qtable){
  for(int a=0; a<num_a-1; a++){
    if(Qtable[s][a]<Qtable[s][a+1]){
      max=Qtable[s][a+1];
    }
    else if(Qtable[s][a]==Qtable[s][a+1]){
      max_a=(int)random(num_a);
    }
    else{
      max=Qtable[s][a];
    }
  }
 return max;
}

int select_action(int s, int num_a, double[][] Qtable){
  for(int a=0; a<num_a-1; a++){
    if(Qtable[s][a]<Qtable[s][a+1]){
      max_a=a+1;
    }
    else{
      max_a=a;
    }
  }
 return max_a;
}

int epsilon_greedy(int epsilon, int s, int num_a, double[][] Qtable){
  if(epsilon>(int)random(100)){
    select_a = (int)random(num_a);
  }
  else{
    select_a = select_action(s, num_a, Qtable);
  }
  return select_a;
}

int s=0 ,e=10;
double alpha = 0.5, gamma = 0.9;

void episode(double[][] Qtable){
  for(int i=0; i<e; i++){
    epsilon_greedy(e, s, 2, Qtable);
    Qtable[s][select_a] = (1-alpha) * Qtable[s][select_a] + alpha*(machine_reward(s, select_a) + gamma * max_Qval(machine_sd(s, select_a), 2 , Qtable));
    s = machine_sd(s, select_a);
    if(s==1&&select_a==1){
      break;
    }
  }
}

void setup(){
  randomSeed(second());
  Qtable[0][0]=0.0;Qtable[0][1]=0.0;Qtable[1][0]=0.0;Qtable[1][1]=0.0;
  for(int i=0; i<100; i++){
    episode(Qtable);
  }
  println("Q[0][0] = "+Qtable[0][0]+", Q[0][1] = "+Qtable[0][1]);
  println("Q[1][0] = "+Qtable[1][0]+", Q[1][1] = "+Qtable[1][1]);
}
