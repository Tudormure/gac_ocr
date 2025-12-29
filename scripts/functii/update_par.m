function parameters = update_par(parameters,grads,learning_rate)
    
    parameters.W1 = parameters.W1 - learning_rate * grads.dW1;
    parameters.b1 = parameters.b1 - learning_rate * grads.db1;
    parameters.W2 = parameters.W2 - learning_rate * grads.dW2;
    parameters.b2 = parameters.b2 - learning_rate * grads.db2;
  

end