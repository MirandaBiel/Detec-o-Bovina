% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '16-08.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = rgb2gray(inputImage); % Se a imagem for colorida, converter para escala de cinza

% Definir parâmetros para segmentação
numClusters = 6; % Definir o número de clusters
numLargestToRemove = 3; % Número de clusters de maior área a remover

% Aplicar a segmentação K-means
binaryImageKmeans = kmeansSegmentation(inputImage, numClusters, numLargestToRemove);


