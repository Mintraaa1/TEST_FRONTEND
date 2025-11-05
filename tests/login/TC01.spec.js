import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
   test.setTimeout(120_000);

  await page.goto('http://localhost:5173/', { waitUntil: 'load' });

  await page.getByRole('link', { name: 'Join Us' }).click();
  await page.getByRole('link', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).fill('nn2@gmail.com');
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).click();
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).fill('Nn123456789');
  await page.getByRole('button', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('button', { name: 'Book Now' }).click();
  await page.getByRole('textbox').fill('2025-11-15');
  await page.getByRole('button', { name: '06:45' }).click();
  await page.getByRole('button', { name: 'จองต่อ' }).click();
  await page.getByRole('button', { name: '+' }).click();
  await page.getByText('ชื่อกลุ่ม', { exact: true }).click();
  await page.getByRole('textbox', { name: 'กรุณาระบุชื่อกลุ่ม' }).click();
  await page.getByRole('textbox', { name: 'กรุณาระบุชื่อกลุ่ม' }).fill('GR-86');
  await page.getByRole('button', { name: 'จองต่อ' }).click();
  await page.getByRole('checkbox', { name: 'ต้องการเลือกแคดดี้' }).check();
  await page.getByRole('img', { name: 'C21' }).click();
  await page.getByRole('img', { name: 'Ccaddy2' }).click();
  await page.getByRole('button', { name: 'ยืนยันการจอง' }).click();
  await page.getByRole('button', { name: 'ดำเนินการชำระเงิน' }).click();
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('42424242@gmail.com');
  await page.getByRole('textbox', { name: 'Card number' }).click();
  await page.getByRole('textbox', { name: 'Card number' }).fill('4242 4242 4242 42424');
  await page.getByRole('textbox', { name: 'Expiration' }).click();
  await page.getByRole('textbox', { name: 'Expiration' }).fill('12 / 34');
  await page.getByRole('textbox', { name: 'CVC' }).click();
  await page.getByRole('textbox', { name: 'CVC' }).fill('123');
  await page.getByRole('textbox', { name: 'Cardholder name' }).click();
  await page.getByRole('textbox', { name: 'Cardholder name' }).fill('42424242');
  await page.getByTestId('hosted-payment-submit-button').click();
  await page.waitForTimeout(4000);
  //await page.getByRole('button', { name: 'ไปยังโปรไฟล์ของฉัน' }).click();
});