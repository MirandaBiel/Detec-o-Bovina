function cluster_removal_GUI()
    % Inicializar a GUI
    fig = figure('Name', 'Remoção de Clusters', 'Position', [100, 100, 800, 600]);

    % Diretório contendo as imagens
    image_folder = 'imagens padrao'; % Substitua pelo caminho da sua pasta de imagens
    image_files = dir(fullfile(image_folder, '18-141.jpg')); % Obtendo arquivos de imagem
    num_clusters = 10; % Número de clusters para K-means

    % Carregar a imagem
    img_path = fullfile(image_folder, image_files(1).name);
    img = imread(img_path);
    filteredImage = gaussianLowPassFilterRGB(img, [7 7], 4);
    
    % Converter para o espaço de cores LAB (Luminância e cromaticidade)
    lab_img = rgb2lab(filteredImage);

    % Reshape a imagem para aplicar K-means (cada pixel é um ponto)
    img_reshape = reshape(lab_img, [], 3);

    % Aplica K-means (cada pixel será associado a um cluster)
    rng(42); % Definir a semente
    [cluster_idx, ~] = kmeans(double(img_reshape), num_clusters, 'Distance', 'sqeuclidean', 'MaxIter', 200);

    % Converter o índice do cluster em formato de imagem (matriz 2D)
    segmented_image = reshape(cluster_idx, size(img, 1), size(img, 2));

    % Criar o painel de visualização
    img_ax = axes('Parent', fig, 'Position', [0.1, 0.3, 0.4, 0.6]);
    imshow(img, 'Parent', img_ax);
    title(img_ax, 'Imagem Original');

    segmented_ax = axes('Parent', fig, 'Position', [0.55, 0.3, 0.4, 0.6]);
    imshow(label2rgb(segmented_image), 'Parent', segmented_ax);
    title(segmented_ax, 'Imagem Segmentada');

    % Criar lista de seleção de clusters
    cluster_list = uicontrol('Style', 'listbox', 'Parent', fig, 'Max', num_clusters, 'Min', 0, ...
                             'Position', [100, 50, 200, 100], ...
                             'String', arrayfun(@(x) ['Cluster ' num2str(x)], 1:num_clusters, 'UniformOutput', false));

    % Criar botão de exclusão
    uicontrol('Style', 'pushbutton', 'Parent', fig, 'Position', [320, 80, 100, 40], ...
              'String', 'Remover Clusters', 'Callback', @(src, event) remove_clusters());

    % Função de remoção de clusters
    function remove_clusters()
        % Obter clusters selecionados pelo usuário
        selected_clusters = get(cluster_list, 'Value');
        
        % Criar uma cópia da imagem segmentada
        bin_img = segmented_image;
        
        % Remover os clusters selecionados
        for k = selected_clusters
            bin_img(segmented_image == k) = 0; % Definir os clusters como 0 (preto)
        end

        % Atualizar a imagem binária
        bin_img = imbinarize(bin_img); % Garantir que seja uma imagem binária
        figure, imshow(bin_img), title('Imagem com Clusters Removidos');
    end
end
