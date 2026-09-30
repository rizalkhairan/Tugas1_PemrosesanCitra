classdef ImageEditorState < handle
    % Image arrays and edit history shared by all editing tabs.
    properties (SetAccess = private)
        OriginalImage = []
        CurrentImage = []
        PreviewImage = []
        HasPreview = false
    end

    properties (Access = private)
        undoStack = {}
        redoStack = {}
    end

    methods
        function loadImage(obj, image)
            obj.OriginalImage = image;
            obj.CurrentImage = image;
            obj.PreviewImage = image;
            obj.HasPreview = false;
            obj.undoStack = {};
            obj.redoStack = {};
        end

        function preview(obj, image)
            obj.PreviewImage = image;
            obj.HasPreview = true;
        end

        function apply(obj)
            if ~obj.HasPreview
                return;
            end
            if ~isequal(obj.CurrentImage, obj.PreviewImage)
                obj.undoStack{end+1} = obj.CurrentImage;
                obj.CurrentImage = obj.PreviewImage;
                obj.redoStack = {};
            end
            obj.HasPreview = false;
        end

        function cancel(obj)
            obj.PreviewImage = obj.CurrentImage;
            obj.HasPreview = false;
        end

        function undo(obj)
            if ~obj.canUndo()
                return;
            end
            obj.redoStack{end+1} = obj.CurrentImage;
            obj.CurrentImage = obj.undoStack{end};
            obj.undoStack(end) = [];
            obj.cancel();
        end

        function redo(obj)
            if ~obj.canRedo()
                return;
            end
            obj.undoStack{end+1} = obj.CurrentImage;
            obj.CurrentImage = obj.redoStack{end};
            obj.redoStack(end) = [];
            obj.cancel();
        end

        function available = canUndo(obj)
            available = ~isempty(obj.undoStack);
        end

        function available = canRedo(obj)
            available = ~isempty(obj.redoStack);
        end
    end
end
