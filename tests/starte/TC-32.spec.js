import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:5173/');
  await page.getByRole('link', { name: 'Join Us' }).click();
  await page.getByRole('link', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('link', { name: 'เข้าสู่ระบบที่นี่' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).fill('s3@gmail.com');
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).click();
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).fill('Nn123456789');
  await page.getByRole('button', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('link', { name: 'แจ้งปัญหา' }).click();
  await page.getByRole('textbox', { name: 'เลขหลุม' }).nth(1).click();
  await page.getByRole('textbox', { name: 'เลขหลุม' }).nth(1).fill('1');
  await page.getByRole('button', { name: 'ยืนยัน' }).nth(1).click();
  await page.getByRole('button', { name: 'ตกลง' }).click();
});