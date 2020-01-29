function outputMap = parseSUMOMap( map, sumo )
%parseSUMOMap This function parses a SUMO map file downloaded as it being
%generated by SUMO netconvert
%
%  Input  :
%     map       : Structure containing all map settings (filename, path,
%                 simplification tolerance to be used, etc).
%     sumo      : Structure containing all the SUMO settings (maximum
%                 number of vehicles, start time, end time, etc.)
%
%  Output :
%     outputMap : The map structure extracted from the map file or loaded
%                 from the preprocessed folder and updated until this point.
%
% Copyright (c) 2019-2020, Ioannis Mavromatis
% email: ioan.mavromatis@bristol.ac.uk

    tic
    
    % Find all the building polygons and put them in an array
    buildings = [];
    foliage = [];
    polygonIDs = traci.polygon.getIDList();
    for i = 1:length(polygonIDs)
        polygonType{i} = traci.polygon.getType(polygonIDs{i});
        if strcmp(polygonType{i},'building')
            buildings = polygonAddition(buildings,polygonIDs{i},i);
        elseif strcmp(polygonType{i},'forest') || strcmp(polygonType{i},'natural')
            foliage = polygonAddition(foliage,polygonIDs{i},i);
        end
    end
    
    % Get the positions of the traffic lights
    tfPosition = [];
    controlledLanes = [];
    trafficLights = traci.trafficlights.getIDList();
    for i = 1:length(trafficLights)
        controlledLanes{i} = traci.trafficlights.getControlledLanes(trafficLights{i});
        edges = [];
        for k = 1:length(controlledLanes{i})
            if contains(controlledLanes{i}{k},'w')
                continue
            end
            tmp = strsplit(controlledLanes{i}{k},'_');
            edges{k} = tmp{1};
        end
        uniqueControlledLanes = unique(controlledLanes{i});
        edges = unique(edges);
        tfPositionTmp = [];
        for k = 1:length(edges)
            lanes  = find(contains(uniqueControlledLanes,edges{k})==true, 1 );
            shape = traci.lane.getShape(uniqueControlledLanes{lanes});
            tfPositionTmp{k} = shape{end};
        end
        tfPosition = [ tfPosition tfPositionTmp ];
    end
    tfPosition = cell2mat(tfPosition);
    tfPosition = reshape(tfPosition,[2, length(tfPosition)/2]);
    
    % Merge adjacent buildings(e.g. backyards)
    if ~isempty(buildings)
        buildingsMerged = mergePolygons(buildings);
    else
        buildingsMerged = [];
    end
    % Merge adjacent foliage (e.g. parks)
    if ~isempty(foliage)
        foliageMerged = mergePolygons(foliage);
    else
        foliageMerged = [];
    end
    
    % Simplify the buildings polygons - this will reduce the number of
    % polygon edges - thus faster calculations later.
    buildingsMerged = simplifyPolygons(buildingsMerged,map);
    
    % Remove the inner holes of the buildings polygons - this simplifies
    % further the polygons.
    buildingsMerged = removeHoles(buildingsMerged);
    
    % Fix the polygons with NaNs
    buildingsMerged = fixNaNs(buildingsMerged);
    
    % Randomise the building height between 15 and 50m
    buildingsMerged = add3rdDimension(buildingsMerged);
    
    % Find the nodes and edges, i.e. the different building corners that
    % are connected and form the different buildings.
    [ nodes, edges ] = findNodesEdges(buildingsMerged);
    
    % Return the values within a structure in the upper function.
    outputMap.buildings = buildingsMerged;
    outputMap.buildingsAnimation = buildings;
    outputMap.edges = edges;
    outputMap.nodes = nodes;
    outputMap.foliage = foliageMerged;
    outputMap.foliageAnimation = foliage;
    outputMap.trafficLights = tfPosition;

    outputMap.simplTolerance = map.simplificationTolerance;
    tmp = strsplit(sumo.routeFile,'/');
    tmp = strsplit(tmp{end},'.');
    outputMap.name = tmp{1};
    
    % Calculate the bounds finding the minimum/maximum x and y from the
    % polygons parsed from SUMO
    if ~isempty(foliageMerged)
        minX = min(min(buildings(:,2)),min(foliage(:,2)));
        minY = min(min(buildings(:,3)),min(foliage(:,3)));
        maxX = max(max(buildings(:,2)),max(foliage(:,2)));
        maxY = max(max(buildings(:,3)),max(foliage(:,3)));
    else
        minX = min(buildings(:,2));
        minY = min(buildings(:,3));
        maxX = max(buildings(:,2));
        maxY = max(buildings(:,3));
    end
    
    bounds = [ minX, maxX ; minY, maxY ];
    
    outputMap.bbox = bounds;

    verbose('Parsing the map required in total %f seconds.', toc);
    % Print the map
    printMap = readYesNo('Do you want to print the map now?','Y');
    if printMap
        mapPrint( outputMap );
    end
end

