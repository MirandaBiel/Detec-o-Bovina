imageFolder = 'imagens padrao'; % Nome da pasta
imageFile = '19-48.jpg'; % Nome do arquivo da imagem
imagePath = fullfile(imageFolder, imageFile); % Caminho completo da imagem
% Carregar a imagem de entrada
img = imread(imagePath);

% 2. Realizar a aplicação do filtro de escala de cinza à imagem
grayImg = rgb2gray(img);

% 3. Efetuar a aplicação de filtros de suavização para remover ruídos e imperfeições
smoothedImg = imgaussfilt(grayImg, 3); % Filtro Gaussiano com sigma 3 (ajuste conforme necessário)

% 4. Aplicar a limiarização para definir os contornos dos objetos
threshold = graythresh(smoothedImg); % Limiarização automática usando o método de Otsu
binaryImg = imbinarize(smoothedImg, threshold);

% 5. Realizar transformações morfológicas para refinar os resultados
se = strel('disk', 4); % Elemento estruturante circular com raio 3 (ajuste conforme necessário)
morphedImg = imopen(binaryImg, se); % Abertura morfológica para remover pequenos objetos
morphedImg = imclose(morphedImg, se); % Fechamento morfológico para preencher buracos
morphedImg = imfill(morphedImg, 'holes'); % Preencher buracos nos objetos detectados

% 6. Aplicar Watershed para separar vacas próximas
distance = -bwdist(~morphedImg); % Distância transformada negativa
distance = imhmin(distance, 4); % (4) Supressão de mínimos locais para evitar divisões excessivas
waterMask = watershed(distance);
morphedImg(waterMask == 0) = 0; % Aplicação da máscara watershed para separar objetos

% 7. Utilizar detectores de objetos binários (blob) para contagem
blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
                                   'AreaOutputPort', false, ...
                                   'CentroidOutputPort', false, ...
                                   'MinimumBlobArea', 100); % Ajuste o tamanho mínimo do blob conforme necessário

boxes = step(blobAnalyzer, morphedImg); % Obtenção das caixas delimitadoras

% 8. Exibição do Resultado Final com Marcação dos Objetos Detectados
figure;

% Subplot 1: Imagem Original
subplot(2, 3, 1);
imshow(img);
title('Imagem Original');

% Subplot 2: Imagem em Escala de Cinza
subplot(2, 3, 2);
imshow(grayImg);
title('Escala de Cinza');

% Subplot 3: Imagem Suavizada com Filtro Gaussiano
subplot(2, 3, 3);
imshow(smoothedImg);
title('Suavização Gaussiana');

% Subplot 4: Imagem Limiarizada
subplot(2, 3, 4);
imshow(binaryImg);
title('Limiarização');

% Subplot 5: Imagem com Transformações Morfológicas e Watershed
subplot(2, 3, 5);
imshow(morphedImg);
title('Transformações Morfológicas + Watershed');

% Subplot 6: Imagem Final com Detecção de Blobs
subplot(2, 3, 6);
imshow(img);
hold on;

% Desenhar retângulos ao redor dos objetos detectados
for k = 1:size(boxes, 1)
    rectangle('Position', boxes(k, :), 'EdgeColor', 'r', 'LineWidth', 2);
end

title(['Detectores de Blob - Objetos: ', num2str(size(boxes, 1))]);
hold off;
