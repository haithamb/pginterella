function [allowedTaskIndex] = getAllowedTasks(Group,ObservedTasks,Tasks)

% find all nonzero indices in Observed Tasks 
TaskIndices = find(ObservedTasks); % This says which tasks has been observed 
% find which of these belong to Group 


for i = 1:length(TaskIndices) % Loop over all observed tasks, check wether they belong to group 
    
    GroupDum = Tasks(TaskIndices(i)).param.Group; % first entry, second entry and so on .. 
    if GroupDum == Group % In case the observerd task was in Group 
        allowedTaskIndex(i,:) = TaskIndices(i);
    end
    
    
end