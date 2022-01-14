<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_Auth extends CI_Model
{
	
	public function check_register_data($username, $email, $phone){
		$this->db->where('userName', $username);
		$this->db->or_where('userEmail', $email);
		$this->db->or_where('userPhone', $phone);
		$row = $this->db->get('users')->num_rows();
		if($row > 0){
			return true;
		}else{
			return false;
		}
	}
	public function register() {
		$username =  $this->input->post('username');
		$password = md5($this->input->post('password'));
		$email = $this->input->post('email');
		$phone = $this->input->post('phone');
		if($this->check_register_data($username, $email, $phone)){
			$res = [
				'status' => false,
				'id' => null,
				'message' => 'Username, email atau phone telah terdaftar',
			];
			return $res;
		}
		$data = [
			'userName' =>  $username,
			'userPassword' => $password,
			'userEmail' => $email,
			'userPhone' => $phone,
			'userCreatedAt' => date('Y-m-d H:i:s'),
			'userUpdatedAt' => date('Y-m-d H:i:s'),
		];
		if ($this->db->insert('users', $data)) {
			$res = [
				'status' => true,
				'message' => 'Selamat, Anda berhasil mendaftar!',
				'data' => [
					'id' => $this->db->insert_id(),
					'username' => $username,
					'email' => $email,
					'phone' => $phone,
					'photo' => '',
					'createdAt' => date('Y-m-d H:i:s'),
					'updatedAt' => date('Y-m-d H:i:s'),
				],
			];
			return $res;
		}else{
			$res = [
				'status' => false,
				'id' => null,
				'message' => 'Mohon maaf, terjadi kesalahan!',
			];
			return $res;
		}
	}
	public function login() {
		$username = $this->input->post('username');
		$password = md5($this->input->post('password'));
		if(!$this->check_register_data($username, $username, $username)){
			$res = [
				'status' => false,
				'id' => null,
				'message' => 'Username, email atau phone tidak ditemukan',
			];
			return $res;
		}
		$query = "SELECT * FROM users 
				WHERE (userName = '".$username."' 
				OR userEmail = '".$username."' 
				OR userPhone = '".$username."') 
				AND userPassword = '".$password."'";
		$result = $this->db->query($query);
		if($result->num_rows() > 0){
			$data = $result->row();
			$res = [
				'status' => true,
				'message' => 'Selamat, Anda berhasil login!',
				'data' => [
					'id' => $data->userId,
					'username' => $data->userName,
					'email' => $data->userEmail,
					'phone' => $data->userPhone,
					'photo' => $data->userPhoto,
					'createdAt' => $data->userCreatedAt,
					'updatedAt' => $data->userUpdatedAt,
				],
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Password salah!',
			];
		}
		return $res;
	}
}
