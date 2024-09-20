% Diretório contendo as imagens
image_folder = 'imagens padrao'; % Substitua pelo caminho da sua pasta de imagens
image_files = dir(fullfile(image_folder, '21-05.jpg')); % Obtendo arquivos de imagem

% Número de clusters para K-means
num_clusters = 8; % Pode ajustar dependendo do cenário

% Percorre todas as imagens na pasta
for i = 1:length(image_files)
    
    % Carregar imagem
    img_path = fullfile(image_folder, image_files(i).name);
    img = imread(img_path);
    
    % Converter para o espaço de cores LAB (Luminância e cromaticidade)
    lab_img = rgb2lab(img);

    % Reshape a imagem para aplicar K-means (cada pixel é um ponto)
    img_reshape = reshape(lab_img, [], 3);

    % Aplica K-means (cada pixel será associado a um cluster)
    % Usa 'sqeuclidean' para a distância entre pixels
    [cluster_idx, ~] = kmeans(double(img_reshape), num_clusters, 'Distance', 'sqeuclidean', 'MaxIter', 200);

    % Converter o índice do cluster em formato de imagem (matriz 2D)
    segmented_image = reshape(cluster_idx, size(img, 1), size(img, 2));

    % Mostrar a imagem original e a segmentada
    figure;
    subplot(1, 2, 1), imshow(img), title('Imagem Original');
    subplot(1, 2, 2), imshow(label2rgb(segmented_image)), title(['Segmentação (K = ' num2str(num_clusters) ')']);

end
