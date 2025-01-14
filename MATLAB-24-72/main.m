% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '24-72.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = rgb2gray(inputImage); % Se a imagem for colorida, converter para escala de cinza

% Definir parâmetros para segmentação
numClusters = 5; % Definir o número de clusters
numLargestToRemove = 4; % Número de clusters de maior área a remover

filteredImage = gaussianLowPassFilterRGB(inputImage, [3 3], 2);

% Aplicar a segmentação K-means
binaryImageKmeans = kmeansSegmentation(filteredImage, numClusters, numLargestToRemove);
figure;
imshow(binaryImageKmeans);
title('Imagem binarizada');

% Aplicar operações morfológicas para refinar a imagem binária
%refinedImage = morphOperations(resultImage);
%figure;
%imshow(refinedImage);
%title('Imagem Refinada após Operações Morfológicas');

% watershed
separatedImage = separarObjetos(binaryImageKmeans);
figure;
imshow(separatedImage);
title('Imagem separada');

% Contar os objetos usando análise de blobs
numObjects = contarObjetosBlob2(inputImage, binaryImageKmeans, true);

% Exibir resultados
fprintf('Número de animais detectados: %d\n', numObjects);


