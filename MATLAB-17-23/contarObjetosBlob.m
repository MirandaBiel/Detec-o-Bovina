function numObjects = contarObjetosBlob(binaryImage)
    % Função para contar objetos na imagem binária usando análise de blobs
    % binaryImage: Imagem binária (0 e 1)
    
    % Criar o objeto BlobAnalysis
    blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
                                       'AreaOutputPort', false, ...
                                       'CentroidOutputPort', false, ...
                                       'MinimumBlobArea', 100); % Ajuste o valor da área mínima
    
    % Detectar blobs e obter caixas delimitadoras
    boxes = step(blobAnalyzer, binaryImage);
    
    % Contar o número de caixas delimitadoras, que corresponde ao número de blobs
    numObjects = size(boxes, 1);
    
    % Exibir as caixas delimitadoras na imagem
    figure;
    imshow(binaryImage);
    hold on;
    for i = 1:size(boxes, 1)
        rectangle('Position', boxes(i,:), 'EdgeColor', 'r', 'LineWidth', 2);
    end
    hold off;
    title('Objetos detectados com análise de blobs');
end
