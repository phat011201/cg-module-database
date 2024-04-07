-- Active: 1711366250156@@127.0.0.1@3306@cg_resort
-- 2. Hiển thị thông tin của tất cả nhân viên trong hệ thống có tên bắt đầu bằng chữ cái "H", "T" hoặc "K" và có tối đa 15 ký tự.
SELECT *
FROM employee
WHERE LEFT(`name`, 1) IN ('H', 'T', 'K') AND LENGTH(`name`) <= 15 AND is_delete = 0;

-- 3. Hiển thị thông tin của tất cả khách hàng trong độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở "Sài Gòn" hoặc "Quảng Nam".
SELECT *
FROM customer
WHERE `address` IN ('Saigon', 'Quang Nam') AND is_delete = 0 AND YEAR(CURDATE())-YEAR(`date_of_birth`) BETWEEN 18 AND 50;

-- 4. Đếm số lần mỗi khách hàng đã đặt phòng. Kết quả hiển thị được sắp xếp theo thứ tự tăng dần theo số lần đặt phòng của khách hàng.
-- Chỉ đếm khách hàng có tên loại khách hàng là "Diamond".
SELECT ctm.id, ctm.name, ct.name as customer_type_name, COUNT(ctr.id) as number_of_bookings
FROM `contract` ctr
JOIN customer ctm ON ctr.customer_id = ctm.id
JOIN customer_type ct ON ctm.customer_type_id = ct.id
WHERE ctm.customer_type_id = 4
AND ctm.is_delete = 0 AND ctr.is_delete = 0
GROUP BY ctm.id, ctm.name, ct.name
ORDER BY COUNT(ctr.id) ASC;

-- 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet)
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
SELECT ctr.customer_id, ctm.name, ctmt.name as customer_type_name, ctr.id as contract_id, fclt.name as facility_name, ctr.start_date, ctr.end_date, SUM(fclt.cost + ctr.deposit * fclt.max_people) as total_cost
FROM `contract` ctr
JOIN customer ctm ON ctr.customer_id = ctm.id
JOIN customer_type ctmt ON ctm.customer_type_id = ctmt.id
JOIN facility fclt ON ctr.facility_id = fclt.id
WHERE ctm.is_delete = 0 AND ctr.is_delete = 0 AND fclt.is_delete = 0 AND ctmt.is_delete = 0
GROUP BY ctr.customer_id;

-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2023 (Quý 1 là tháng 1, 2, 3).
SELECT fclt.id, fclt.name, fclt.area, fclt.cost, fcltt.name as facility_type_name
FROM facility fclt
JOIN facility_type fcltt ON fclt.facility_type_id = fcltt.id
LEFT JOIN (
    SELECT DISTINCT ctr.facility_id
    FROM `contract` ctr
    WHERE YEAR(ctr.start_date) = 2023 AND MONTH(ctr.start_date) IN (1, 2, 3)
) ctr ON fclt.id = ctr.facility_id
WHERE ctr.facility_id IS NULL
AND fclt.is_delete = 0
GROUP BY fclt.id;

-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ
-- đã từng được khách hàng đặt phòng trong năm 2022,
-- nhưng chưa từng được khách hàng đặt phòng trong năm 2023.
SELECT fclt.id, fclt.name, fclt.area, fclt.max_people, fclt.cost, fcltt.name as facility_type_name
FROM facility fclt
JOIN facility_type fcltt ON fclt.facility_type_id = fcltt.id
WHERE fclt.id IN (
    SELECT DISTINCT ctr.facility_id
    FROM `contract` ctr
    WHERE YEAR(ctr.start_date) = 2022
)
AND fclt.id NOT IN (
    SELECT DISTINCT ctr.facility_id
    FROM `contract` ctr
    WHERE YEAR(ctr.start_date) = 2023
)
AND fclt.is_delete = 0 AND fcltt.is_delete = 0
GROUP BY fclt.id;

-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
-- Option 1: use DISTINCT
SELECT DISTINCT name
FROM customer
WHERE is_delete = 0;

-- Option 2: use GROUP BY
SELECT name
FROM customer
WHERE is_delete = 0
GROUP BY name;

-- Option 3: use GROUP BY and COUNT
SELECT name
FROM customer
WHERE is_delete = 0
GROUP BY name
HAVING COUNT(name) = 1;

-- 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2022 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT MONTH(start_date) as month, COUNT(customer_id) as number_of_customers
FROM `contract`
WHERE YEAR(start_date) = 2022
AND is_delete = 0
GROUP BY MONTH(start_date);

-- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong,ngay_ket_thuc,tien_dat_coc,so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
SELECT ctr.id as contract_id, ctr.start_date, ctr.end_date, ctr.deposit, SUM(ctrdt.quantity) as number_of_services
FROM `contract` ctr
JOIN  contract_detail ctrdt ON ctr.id = ctrdt.contract_id
AND ctr.is_delete = 0 AND ctrdt.is_delete = 0
GROUP BY ctr.id;

-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
SELECT DISTINCT ctr.id as contract_id, ctm.name, atfclt.name as facility_name, atfclt.cost, atfclt.unit, atfclt.status
FROM `contract` ctr
JOIN `contract_detail` ctrdl ON ctr.id = ctrdl.contract_id
JOIN customer ctm ON ctr.customer_id = ctm.id
JOIN attach_facility atfclt ON ctrdl.attach_facility_id = atfclt.id
WHERE ctm.customer_type_id = 4 AND ctm.address IN ('Vinh', 'Quang Ngai')
AND ctr.is_delete = 0 AND ctrdl.is_delete = 0 AND ctm.is_delete = 0 AND atfclt.is_delete = 0;

-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc
-- của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2022 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2023.
SELECT ctr.id as contract_id, epy.name as employee_name, ctm.name as customer_name, ctm.phone_number, fclt.name as facility_name, SUM(ctrdl.attach_facility_id) as number_of_services, ctr.deposit
FROM `contract` ctr
JOIN `contract_detail` ctrdl ON ctr.id = ctrdl.contract_id
JOIN employee epy ON ctr.employee_id = epy.id
JOIN customer ctm ON ctr.customer_id = ctm.id
JOIN facility fclt ON ctr.facility_id = fclt.id
WHERE (YEAR(ctr.start_date) = 2022 AND MONTH(ctr.start_date) IN (10, 11, 12))
AND ctr.is_delete = 0 AND ctrdl.is_delete = 0 AND epy.is_delete = 0 AND ctm.is_delete = 0 AND fclt.is_delete = 0
GROUP BY ctr.id;

-- 13. Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
SELECT atfclt.id, atfclt.name, COUNT(ctrdl.attach_facility_id) as number_of_facilities
FROM `contract` ctr
JOIN `contract_detail` ctrdl ON ctr.id = ctrdl.contract_id
JOIN attach_facility atfclt ON ctrdl.attach_facility_id = atfclt.id
WHERE ctr.is_delete = 0 AND ctrdl.is_delete = 0 AND atfclt.is_delete = 0
GROUP BY atfclt.id
ORDER BY COUNT(ctrdl.attach_facility_id) DESC;

-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT atfclt.id, atfclt.name, COUNT(ctrdl.attach_facility_id) as number
FROM `contract` ctr
JOIN `contract_detail` ctrdl ON ctr.id = ctrdl.contract_id
JOIN attach_facility atfclt ON ctrdl.attach_facility_id = atfclt.id
WHERE ctr.is_delete = 0 AND ctrdl.is_delete = 0 AND atfclt.is_delete = 0
GROUP BY atfclt.id
HAVING COUNT(ctrdl.attach_facility_id) = 1;

-- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2022 đến 2023.
SELECT epy.id, epy.name, edctdg.name as education_name, pst.name as position_name, epy.phone_number, epy.address
FROM `contract` ctr
JOIN employee epy ON ctr.employee_id = epy.id
JOIN education_degree edctdg ON epy.education_degree_id = edctdg.id
JOIN position pst ON epy.position_id = pst.id
WHERE YEAR(ctr.start_date) BETWEEN 2022 AND 2023
AND epy.is_delete = 0 AND edctdg.is_delete = 0 AND pst.is_delete = 0 AND ctr.is_delete = 0
GROUP BY epy.id;

-- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2022 đến năm 2023.
DELETE FROM employee
WHERE id NOT IN (
    SELECT employee_id
    FROM `contract`
    WHERE YEAR(start_date) BETWEEN 2022 AND 2023
)
AND is_delete = 0;

-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2022 là lớn hơn 10.000.000 VNĐ.
UPDATE customer
SET customer_type_id = 4
WHERE id IN (
    SELECT customer_id
    FROM `contract`
    WHERE YEAR(start_date) = 2022
    GROUP BY customer_id
    HAVING SUM(deposit) > 10000000
)
AND customer_type_id = 3
AND is_delete = 0;

-- 18. Xóa những khách hàng có hợp đồng trước năm 2022 (chú ý ràng buộc giữa các bảng).
UPDATE customer
SET is_delete = 1
WHERE id IN (
    SELECT customer_id
    FROM `contract`
    WHERE YEAR(start_date) < 2022
)
AND is_delete = 0;

-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2022 lên gấp đôi.
UPDATE attach_facility
SET `cost` = `cost` * 2
WHERE id IN (
    SELECT attach_facility_id
    FROM `contract_detail`
    JOIN `contract` ON contract_id = `contract`.id
    WHERE YEAR(start_date) = 2022
    GROUP BY attach_facility_id
    HAVING COUNT(attach_facility_id) > 10
)
AND is_delete = 0;

-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống,
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
SELECT id, name, email, phone_number, date_of_birth, `address`
FROM (
    SELECT id, name, email, phone_number, date_of_birth, `address`
    FROM employee
    WHERE is_delete = 0
    UNION
    SELECT id, name, email_address, phone_number, date_of_birth, `address`
    FROM customer
    WHERE is_delete = 0
) AS emp_cus;