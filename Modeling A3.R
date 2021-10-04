library(sbo)

#modeling stupid back off
At <- sbo_predtable(object = Amt.data, # preloaded example dataset
                   N = 3, # Train a 3-gram model
                   dict = target ~ 0.75, # cover 75% of training corpus
                   .preprocess = sbo::preprocess, # Preprocessing transformation 
                   EOS = ".?!:;", # End-Of-Sentence tokens
                   lambda = 0.4, # Back-off penalization in SBO algorithm
                   L = 3L, # Number of predictions for input
                   filtered = "<UNK>" # Exclude the <UNK> token from predictions
)
#From t, one can rapidly recover the corresponding text predictor, using sbo_predictor()
Ap <- sbo_predictor(At) 
saveRDS(At, "At.rds")

predict(Ap, 'love of my')

Aevaluation <- eval_sbo_predictor(Ap, test = test.data)
library(dplyr)
Ae1 <- Aevaluation %>% summarise(accuracy = sum(correct)/n(), 
                         uncertainty = sqrt(accuracy * (1 - accuracy) / n())
)

Ae2 <- Aevaluation %>% # Accuracy for in-sentence predictions
        filter(true != "<EOS>") %>%
        summarise(accuracy = sum(correct) / n(),
                  uncertainty = sqrt(accuracy * (1 - accuracy) / n())
        )

sapply(list(sbo_predtableA = At, sbo_predtable = t), size_in_MB)
lapply(list(sbo_predictorA = Ap, sbo_predictor = p), chrono_predict)
