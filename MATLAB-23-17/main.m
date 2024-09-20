% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '23-17.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = rgb2gray(inputImage); % Se a imagem for colorida, converter para escala de cinza

bordas = ~detectStrongContoursCanny(grayImage, [0.2 0.5]);
figure;
imshow(bordas);
title('Bordas Canny');

% Definir parâmetros para segmentação
numClusters = 5; % Definir o número de clusters
numLargestToRemove = 3; % Número de clusters de maior área a remover

filteredImage = gaussianLowPassFilterRGB(inputImage, [5 5], 3);

% Aplicar a segmentação K-means
binaryImageKmeans = kmeansSegmentation(filteredImage, numClusters, numLargestToRemove);
figure;
imshow(binaryImageKmeans);
title('Imagem binarizada');

bordas = uint8(bordas) * 255;

resultImage = aplicarMascara(binaryImageKmeans, bordas);
resultImage = binarizeImage(resultImage);
figure;
imshow(resultImage);
title('Segunda imagem binarizada');

% Aplicar operações morfológicas para refinar a imagem binária
%refinedImage = morphOperations(resultImage);
%figure;
%imshow(refinedImage);
%title('Imagem Refinada após Operações Morfológicas');

separatedImage = separarObjetos(resultImage);
figure;
imshow(separatedImage);
title('Imagem separada');

% Contar os objetos usando análise de blobs
numObjects = contarObjetosBlob2(inputImage, separatedImage, true);

% Exibir resultados
fprintf('Número de animais detectados: %d\n', numObjects);


