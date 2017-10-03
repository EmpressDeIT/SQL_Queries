USE CAH_Portal
GO

SELECT u.user_id
	,u.user_first_nm
	,u.user_last_nm
	,BidRequestor.RoleName
	,au.LoweredUserName
	,u.delete_flg
	,au.LastActivityDate
	,u.create_ts
FROM users u
LEFT JOIN (
	SELECT ur.UserId
		,ar.RoleName
	FROM dbo.UserRoles ur
	LEFT JOIN dbo.aspnet_Roles ar
		ON ar.RoleId = ur.RoleId
	) BidRequestor
	ON u.ads_domain_id = BidRequestor.UserId
LEFT JOIN dbo.aspnet_Users au
	ON au.UserId = u.ads_domain_id
	WHERE u.delete_flg != 1
	AND Rolename = 'ConstructionPortalAdmin'
	AND BidRequestor.RoleName IS NOT null
ORDER BY u.user_id;