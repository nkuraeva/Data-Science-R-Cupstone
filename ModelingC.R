library(sbo)

#modeling stupid back off
Ct <- sbo_predtable(object = Amt.data, # preloaded example dataset
                    N = 5, # Train a 5-gram model
                    dict = target ~ 0.75, # cover 75% of training corpus
                    .preprocess = sbo::preprocess, # Preprocessing transformation 
                    EOS = ".?!:;", # End-Of-Sentence tokens
                    lambda = 0.4, # Back-off penalization in SBO algorithm
                    L = 1L, # Number of predictions for input
                    filtered = "<UNK>", "<EOS>" # Exclude the <UNK> token from predictions
)
#From t, one can rapidly recover the corresponding text predictor, using sbo_predictor()
Cp <- sbo_predictor(Ct) 
saveRDS(Ct, "Ct.rds")

predict(Cp, 'love of my')

Cevaluation <- eval_sbo_predictor(Cp, test = test.data)
library(dplyr)
Ce1 <- Cevaluation %>% summarise(accuracy = sum(correct)/n(), 
                                 uncertainty = sqrt(accuracy * (1 - accuracy) / n())
)

Ce2 <- Cevaluation %>% # Accuracy for in-sentence predictions
        filter(true != "<EOS>") %>%
        summarise(accuracy = sum(correct) / n(),
                  uncertainty = sqrt(accuracy * (1 - accuracy) / n())
        )

sapply(list(sbo_predtableA = At, sbo_predtableC = Ct), size_in_MB)
lapply(list(sbo_predictorA = Ap, sbo_predictorC = Cp), chrono_predict)