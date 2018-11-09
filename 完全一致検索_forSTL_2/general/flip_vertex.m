function vertex2 = flip_vertex(vertex)

vertex2 = vertex;
testMean = mean(mean(vertex2(:,1,:)));
vertex2(:,1,:) = (-(vertex2(:,1,:)-testMean) + testMean);

end