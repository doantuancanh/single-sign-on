class StatusConstant
  # http code 400
  INVALID_PARAMS = "INVALID_PARAMS"
  EMAIL_EXISTED = "EMAIL_EXISTED"
  MISSING_PARAMS = "MISSIONG_PARAMS"
  INVALID_DATE_FORMAT = "INVALID_DATE_FORMAT"

  # http code 401
  UNAUTHORIZED = "UNAUTHORIZED"
  TOKEN_EXPIRED = "TOKEN_EXPIRED"
  PASSCODE_EXPIRED = "PASSCODE_EXPIRED"

  # http code 403
  PERMISSION_DENIED = "PERMISSION_DENIED"

  # http code 404
  NOT_FOUND = "NOT_FOUND"
  RESOURCE_NOT_EXIST = "RESOURCE_NOT_EXIST"

  # http code 406
  BUSINESS_FAILURE = "BUSINESS_FAILURE"
end
