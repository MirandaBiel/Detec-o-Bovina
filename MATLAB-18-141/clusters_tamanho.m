% Diretório contendo as imagens
image_folder = 'imagens padrao'; % Substitua pelo caminho da sua pasta de imagens
image_files = dir(fullfile(image_folder, '18-141.jpg')); % Obtendo arquivos de imagem

% Número de clusters para K-means
num_clusters = 8; % Pode ajustar dependendo do cenário

% Definir a semente para o gerador de números aleatórios
seed = 42; % Escolha um valor qualquer para a semente
rng(seed); % Define a semente para controle reprodutível do K-means

% Percorre todas as imagens na pasta
for i = 1:length(image_files)
    
    % Carregar imagem
    img_path = fullfile(image_folder, image_files(i).name);
    img = imread(img_path);
    filteredImage = gaussianLowPassFilterRGB(img, [3 3], 2);
    
    % Converter para o espaço de cores LAB (Luminância e cromaticidade)
    lab_img = rgb2lab(filteredImage);

    % Reshape a imagem para aplicar K-means (cada pixel é um ponto)
    img_reshape = reshape(lab_img, [], 3);

    % Aplica K-means (cada pixel será associado a um cluster)
    % Usa 'sqeuclidean' para a distância entre pixels
    [cluster_idx, ~] = kmeans(double(img_reshape), num_clusters, 'Distance', 'sqeuclidean', 'MaxIter', 200);

    % Converter o índice do cluster em formato de imagem (matriz 2D)
    segmented_image = reshape(cluster_idx, size(img, 1), size(img, 2));

    % Exibir a imagem original e a segmentada
    figure;
    subplot(1, 2, 1), imshow(img), title('Imagem Original');
    subplot(1, 2, 2), imshow(label2rgb(segmented_image)), title(['Segmentação (K = ' num2str(num_clusters) ')']);

    % Calcular a área de cada cluster (número de pixels em cada cluster)
    area_clusters = zeros(1, num_clusters); % Vetor para armazenar a área de cada cluster
    for k = 1:num_clusters
        area_clusters(k) = sum(cluster_idx == k);
    end
    
    % Obter as cores associadas a cada cluster na imagem segmentada
    colors = label2rgb(segmented_image);
    unique_colors = unique(reshape(colors, [], 3), 'rows'); % Obter cores únicas

    % Ordenar as áreas em ordem decrescente e organizar os clusters e cores
    [sorted_areas, sorted_indices] = sort(area_clusters, 'descend');
    sorted_colors = unique_colors(sorted_indices, :); % Ordenar as cores de acordo com a área

    % Exibir no terminal a área e a cor associada a cada cluster (da maior para a menor)
    fprintf('Cluster \tÁrea (pixels) \tCor (RGB)\n');
    for k = 1:num_clusters
        fprintf('%d \t\t%d \t\t[%d, %d, %d]\n', sorted_indices(k), sorted_areas(k), sorted_colors(k, 1), sorted_colors(k, 2), sorted_colors(k, 3));
    end
end
