% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '18-141.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = rgb2gray(inputImage); % Se a imagem for colorida, converter para escala de cinza

% Definir parâmetros para segmentação
numClusters = 20; % Definir o número de clusters
numLargestToRemove = [1 4 7 13 14 15 18 20]; % Número de clusters de maior área a remover

filteredImage = gaussianLowPassFilterRGB(inputImage, [3 3], 2);

% Aplicar a segmentação K-means
binaryImageKmeans = kmeansSegmentation2(filteredImage, numClusters, numLargestToRemove);
figure;
imshow(binaryImageKmeans);
title('Imagem binarizada');

% Salvar a imagem binarizada em um arquivo
outputFolder = 'binaryImagesKmeans'; % Nome da pasta de saída
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder); % Cria a pasta se não existir
end

outputFilePath = fullfile(outputFolder, 'binaryImageKmeans2-8-L-7-3_700_4_1235.png'); % Nome do arquivo de saída
imwrite(binaryImageKmeans, outputFilePath); % Salva a imagem binária
fprintf('Imagem binarizada salva em: %s\n', outputFilePath);
