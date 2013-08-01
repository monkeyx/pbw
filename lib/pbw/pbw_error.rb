module Pbw
	class PbwError < StandardError
	end

	class PbwArgumentError < PbwError
	end

	class PbwOperationError < PbwError
	end
end