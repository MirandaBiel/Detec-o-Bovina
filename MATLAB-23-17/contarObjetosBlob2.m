function numObjects = contarObjetosBlob2(originalImage, binaryImage, useAreaMedian)
    % Função para contar objetos na imagem binária usando análise de blobs
    % e dividir objetos grandes com base na área mediana
    %
    % originalImage: Imagem original sobre a qual as caixas serão desenhadas
    % binaryImage: Imagem binária (0 e 1)
    % useAreaMedian: Se true, considera a área mediana para identificar objetos maiores

    % Criar o objeto vision.BlobAnalysis
    blobAnalyzer = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
                                       'AreaOutputPort', true, ...
                                       'CentroidOutputPort', false, ...
                                       'MinimumBlobArea', 40); % Ajustar o valor da área mínima

    % Detectar blobs, obter as áreas e caixas delimitadoras
    [areas, boxes] = step(blobAnalyzer, binaryImage);

    % Calcular a mediana das áreas
    if useAreaMedian
        medianArea = median(areas);
    end

    % Inicializar a contagem de objetos
    numObjects = 0;

    % Exibir a imagem original
    figure;
    imshow(originalImage);
    hold on;

    % Loop para percorrer os blobs detectados
    for i = 1:size(boxes, 1)
        % Verifica se o uso da mediana está habilitado
        if useAreaMedian
            % Determinar a cor da caixa de acordo com o tamanho relativo à mediana
            if (areas(i) >= 2 * medianArea) && (areas(i) <= 2.2 * medianArea)
                % Considerar como 2 objetos
                numObjects = numObjects + 2;
                boxColor = 'g'; % Verde para 2 objetos
            elseif (areas(i) >= 2.8 * medianArea) && (areas(i) <= 3.2 * medianArea)
                % Considerar como 3 objetos
                numObjects = numObjects + 3;
                boxColor = 'b'; % Azul para 3 objetos
            elseif (areas(i) >= 3.8 * medianArea) && (areas(i) <= 4.2 * medianArea)
                % Considerar como 4 objetos
                numObjects = numObjects + 4;
                boxColor = 'm'; % Magenta para 4 objetos
            else
                % Contar normalmente o objeto como 1
                numObjects = numObjects + 1;
                boxColor = 'r'; % Vermelho para 1 objeto
            end
        else
            % Contar normalmente o objeto
            numObjects = numObjects + 1;
            boxColor = 'r'; % Vermelho para 1 objeto
        end

        % Verificar se a caixa delimitadora possui 4 elementos (posição e tamanho)
        if length(boxes(i,:)) == 4
            % Desenhar o retângulo ao redor do objeto com a cor correspondente
            rectangle('Position', boxes(i,:), 'EdgeColor', boxColor, 'LineWidth', 2);
        else
            warning('A caixa delimitadora não possui 4 elementos.');
        end
    end

    hold off;
    title('Objetos detectados com análise de blobs');
end
