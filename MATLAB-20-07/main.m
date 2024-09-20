% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '20-07.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = rgb2gray(inputImage); % Se a imagem for colorida, converter para escala de cinza

% Definir parâmetros para segmentação
numClusters = 5; % Definir o número de clusters
numLargestToRemove = 4; % Número de clusters de maior área a remover

% Aplicar a segmentação K-means
binaryImageKmeans = kmeansSegmentation(inputImage, numClusters, numLargestToRemove);
figure;
imshow(binaryImageKmeans);
title('Imagem binarizada');

% Aplicar operações morfológicas para refinar a imagem binária
refinedImage = morphOperations(binaryImageKmeans);
figure;
imshow(refinedImage);
title('Imagem Refinada após Operações Morfológicas');

separatedImage = separarObjetos(refinedImage);
figure;
imshow(separatedImage);
title('Imagem separada');

% Contar os objetos usando análise de blobs
numObjects = contarObjetosBlob2(inputImage, separatedImage, true);

% Exibir resultados
fprintf('Número de animais detectados: %d\n', numObjects);


