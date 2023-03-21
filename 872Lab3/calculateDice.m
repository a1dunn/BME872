function coef = calculateDice(groundTruthImage, estimateImage)

% convert input images to logical
groundTruthImage = logical(groundTruthImage);
estimateImage = logical(estimateImage);

% calculate intersection and union
intersection = sum(sum(groundTruthImage & estimateImage));
union = sum(sum(groundTruthImage | estimateImage));

% calculate Dice similarity coefficient
coef = 2 * intersection / union;