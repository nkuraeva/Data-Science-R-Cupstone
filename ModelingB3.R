library(sbo)

#modeling stupid back off
Bt <- sbo_predtable(object = Bmt.data, # preloaded example dataset
                    N = 3, # Train a 3-gram model
                    dict = target ~ 0.75, # cover 75% of training corpus
                    .preprocess = sbo::preprocess, # Preprocessing transformation 
                    EOS = ".?!:;", # End-Of-Sentence tokens
                    lambda = 0.4, # Back-off penalization in SBO algorithm
                    L = 3L, # Number of predictions for input
                    filtered = "<UNK>" # Exclude the <UNK> token from predictions
)
#From t, one can rapidly recover the corresponding text predictor, using sbo_predictor()
Bp <- sbo_predictor(Bt) 
saveRDS(Bt, "Bt.rds")

predict(Bp, 'love of my')
#estimating
Bevaluation <- eval_sbo_predictor(Bp, test = test.data)
library(dplyr)
Be1 <- Bevaluation %>% summarise(accuracy = sum(correct)/n(), 
                         uncertainty = sqrt(accuracy * (1 - accuracy) / n())
)

Be2 <- Bevaluation %>% # Accuracy for in-sentence predictions
        filter(true != "<EOS>") %>%
        summarise(accuracy = sum(correct) / n(),
                  uncertainty = sqrt(accuracy * (1 - accuracy) / n())
        )

sapply(list(sbo_predtableB = Bt, sbo_predtableA = At, sbo_predtable = t), size_in_MB)
lapply(list(sbo_predictorB = Bp, sbo_predictorA = Ap, sbo_predictor = p), chrono_predict)
