function binaryImage = kmeansSegmentation(image, numClusters, numLargestToRemove)
    % Verificar se a imagem está em RGB e convertê-la para o espaço de cor LAB
    if size(image, 3) == 3
        labImage = rgb2lab(image); % Converter para espaço de cor LAB
    else
        labImage = image; % Se for em escala de cinza, usar diretamente
    end
    
    % Remodelar a imagem para aplicar K-means (cada pixel será um ponto no espaço 3D)
    imgReshape = reshape(labImage, [], size(labImage, 3));

    % Definir a semente para o gerador de números aleatórios
    seed = 42; % Escolha um valor qualquer para a semente
    rng(seed); % Define a semente para controle reprodutível do K-means
    
    % Aplicar K-means com parâmetros otimizados
    % Usar 'sqeuclidean' para distância e limitar 'MaxIter' a 200
    [clusterIdx, ~] = kmeans(double(imgReshape), numClusters, ...
                             'Distance', 'sqeuclidean', ...
                             'MaxIter', 200, ...
                             'Replicates', 3);

    % Converter o índice do cluster de volta para o formato de imagem 2D
    clusterIdx = reshape(clusterIdx, size(labImage, 1), size(labImage, 2));
    
    % Identificar o tamanho das áreas de cada cluster
    areas = histcounts(clusterIdx, numClusters);
    
    % Ordenar os clusters por área (do maior para o menor)
    [~, sortedClusterIdx] = sort(areas, 'descend');
    
    % Definir os clusters de maior área a serem removidos (setar para zero)
    largestClusters = sortedClusterIdx(1:numLargestToRemove);
    
    % Criar a imagem binarizada onde os maiores clusters são zero
    binaryImage = true(size(clusterIdx)); % Inicializar com tudo como 1 (positivo)
    
    % Definir pixels dos maiores clusters como 0 (negativo)
    for i = 1:numLargestToRemove
        binaryImage(clusterIdx == largestClusters(i)) = false;
    end
end
