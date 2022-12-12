<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/*

	# 년도 별 수입/지출 동시에
	SELECT YEAR(cash_date), ca.category_kind, SUM(cash_price)
	FROM cash c
		INNER JOIN category ca
		ON c.category_no = ca.category_no
	GROUP BY YEAR(cash_date), ca.category_kind;
	
	# 년도 별 수입/지출 따로
	SELECT YEAR(cash_date), ca.category_kind, SUM(cash_price)
	FROM cash c
		INNER JOIN category ca
		ON c.category_no = ca.category_no
	WHERE ca.category_kind = '수입'
	GROUP BY YEAR(cash_date), ca.category_kind;
	
	# 년도 카테고리별 
	SELECT YEAR(cash_date), ca.category_kind, ca.category_name, SUM(cash_price)
	FROM cash c
		INNER JOIN category ca
		ON c.category_no = ca.category_no
	GROUP BY YEAR(cash_date), ca.category_kind, ca.category_name;
	
	# 년도 +  월별 수입/지출
	SELECT MONTH(cash_date), ca.category_kind, SUM(cash_price)
	FROM cash c
		INNER JOIN category ca
		ON c.category_no = ca.category_no
	WHERE YEAR(cash_date) = 2022 AND ca.category_kind = '수입'
	GROUP BY MONTH(cash_date), ca.category_kind;
	
	# 년도 +  월별 수입/지출 + 카테고리
	SELECT MONTH(cash_date), ca.category_kind, ca.category_name, SUM(cash_price)
	FROM cash c
		INNER JOIN category ca
		ON c.category_no = ca.category_no
	WHERE YEAR(cash_date) = 2021
	GROUP BY MONTH(cash_date), ca.category_kind, ca.category_name;

*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>