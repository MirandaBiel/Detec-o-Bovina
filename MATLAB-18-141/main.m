% Diretório contendo as imagens binárias segmentadas
image_folder = 'binaryImagesKmeans'; % Substitua pelo caminho da sua pasta de imagens
image_files = dir(fullfile(image_folder, 'imagem_omitidos_Cluster_1_ 4_ 7_13_14_15_18_20.png'));
% A IMAGEM BINARIZADA FOI OBTIDA SELECIONANDO CLUSTERS NO PROGRAMA MAIN 0


% Definir o caminho da pasta e o nome do arquivo da imagem
imageF = 'imagens padrao'; % Nome da pasta
imageFi = '18-141.jpg'; % Nome do arquivo da imagem
imageP = fullfile(imageF, imageFi); % Caminho completo da imagem

% Carregar a imagem de entrada
inputImage = imread(imageP);

% Percorre todas as imagens na pasta
for i = 1:length(image_files)
    
    % Carregar imagem binária
    img_path = fullfile(image_folder, image_files(i).name);
    binaryImageKmeans = imread(img_path);
    figure;
    imshow(binaryImageKmeans);
  
    % Aplicar operações morfológicas para refinar a imagem binária
    refinedImage = morphOperations(binaryImageKmeans);
    figure;
    imshow(refinedImage);
    title(['Imagem Refinada após Operações Morfológicas: ', image_files(i).name]);

    % Separar os objetos na imagem refinada
    separatedImage = separarObjetos2(refinedImage);
    figure;
    imshow(separatedImage);
    title(['Imagem Separada: ', image_files(i).name]);

    % Contar os objetos usando análise de blobs
    numObjects = contarObjetosBlob2(inputImage, separatedImage, false);

    % Exibir o número de objetos detectados no terminal
    fprintf('Número de animais detectados na imagem %s: %d\n', image_files(i).name, numObjects);
    
end
