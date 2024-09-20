% Definir o caminho da pasta e o nome do arquivo da imagem
imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '17-23.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imagePath);

% Converter a imagem para escala de cinza
grayImage = convertToGray(inputImage);

% Aplicar binarização inicial
binaryImage = imbinarize(grayImage);

% Definir o threshold para a detecção de contornos
threshold = [0.2, 0.5]; % Limiar para o Canny (ajuste conforme necessário)

% Detectar contornos fortes usando o filtro Canny e inverter
contourImage = detectStrongContoursCanny(binaryImage, threshold);

% Exibir a imagem com os contornos detectados
figure;
imshow(contourImage);
title('Contornos detectados com Canny (Fundo Branco, Contornos Pretos)');

% Preencher os buracos internos nas bordas detectadas
filledEdges = imfill(contourImage, 'holes');

% Aplicar operações morfológicas para suavizar as bordas e remover pequenos objetos
se = strel('disk', 5); % Elemento estruturante
smoothedEdges = imclose(filledEdges, se); % Fechamento para suavizar bordas

% Aplicar a transformada da distância
distTransform = -bwdist(~smoothedEdges);

% Aplicar o algoritmo watershed para segmentar a imagem
watershedLabels = watershed(distTransform);

% Remover os pixels de fronteira do watershed
segmentedImage = smoothedEdges;
segmentedImage(watershedLabels == 0) = 0;

% Exibir a imagem segmentada após watershed
figure;
imshow(segmentedImage);
title('Imagem Segmentada após Watershed');

% Contar os objetos usando análise de blobs
numObjects = contarObjetosBlob(segmentedImage);

% Exibir resultados
fprintf('Número de animais detectados: %d\n', numObjects);
