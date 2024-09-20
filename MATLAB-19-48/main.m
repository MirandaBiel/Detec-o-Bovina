% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '19-48.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = convertToGray(inputImage);

% Definir a frequência de corte para o filtro passa-alta
cutoffFrequency = 0.01; % Ajuste esse valor conforme necessário (entre 0 e 0.5)

% Aplicar o filtro passa-alta
filteredImage = filtroPassaAlta(grayImage, cutoffFrequency);

% Definir parâmetros do filtro Gaussiano
kernelSize = [6 6]; % Tamanho do kernel (por exemplo, 5x5)
sigma = 6; % Desvio padrão

% Aplicar a suavização
smoothImage = applySmoothing(grayImage, kernelSize, sigma);

% Aplicar a primeira limiarização
binaryImage = binarizeImage(smoothImage, 0.4); % Usando o limiar automático
figure;
imshow(binaryImage);
title('Primeira binarização');

% Aplicar uma máscara para realçar os contornos com a imagem filtrada
resultImage = aplicarMascara(binaryImage, filteredImage);
figure;
imshow(resultImage);
title('Aguçamento da imagem binarizada');

% Aplicar a segunda limiarização
binaryImage = binarizeImage(resultImage); % Ajuste o limiar conforme necessário
figure;
imshow(binaryImage);
title('Segunda binarização');

% Aplicar operações morfológicas para refinar a imagem binária
refinedImage = morphOperations(binaryImage);
figure;
imshow(refinedImage);
title('Imagem Refinada após Operações Morfológicas');

separatedImage = separarObjetos(refinedImage);

% Contar os objetos usando análise de blobs
numObjects = contarObjetosBlob2(inputImage, separatedImage, true);

% Exibir resultados
fprintf('Número de animais detectados: %d\n', numObjects);


