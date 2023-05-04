package com.HBS;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.*;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class HBSHashing {
	
	protected static String Salt = "";
	protected static String Password = "Password";
	protected static String HashedPassword = "";
	
	public static String getSalt() {
		return Salt;
	}
	public static String getPassword() {
		return Password;
	}
	public static String getHashedPassword() {
		return HashedPassword;
	}
	
	
	public static String PasswordHash(String pswd) throws InvalidKeySpecException {
		
		Password = pswd;
		
		try {
			SecureRandom random = new SecureRandom();
			byte[] salt = new byte[16]; 
			random.nextBytes(salt);
			System.out.println("\n"+salt.toString());
			
			KeySpec spec = new PBEKeySpec(getPassword().toCharArray(), salt, 65536, 128);
			SecretKeyFactory f;
			System.out.println(spec.toString());
			
			f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			System.out.println(f.toString());
			
			byte[] hash = f.generateSecret(spec).getEncoded();
			System.out.println(hash.toString());
			
			Base64.Encoder enc = Base64.getEncoder();
			
			Salt = enc.encodeToString(salt);
			HashedPassword = enc.encodeToString(hash);
			
			System.out.printf("salt: %s%n", getSalt());
			System.out.printf("hash: %s%n", getHashedPassword());
			
			return getHashedPassword();
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	protected static byte[] GenerateSalt() {
			
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[16]; 
		random.nextBytes(salt);
		//System.out.println("\nSalt : "+salt.toString());
		
		return salt; 
	}
		
	protected static byte[] GenerateHash(String password, byte[] salt) {
			
		byte[] hash = null;
		
		try 
		{
			KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 128);
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			hash = skf.generateSecret(spec).getEncoded();
			//System.out.println("\nHash : "+hash.toString());
			
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return hash;
		
	}
	
	public static String HashPaswword(String pswd) { 

		Password = pswd;
		
		byte[] salt = GenerateSalt();
		byte[] hash = GenerateHash(Password, salt);
		
		Salt = Base64.getEncoder().encodeToString(salt);
		HashedPassword = Base64.getEncoder().encodeToString(hash);
		
		System.out.println("Password: " + Password); 
		System.out.println("Salt: " + getSalt());
		System.out.println("Hash: " + getHashedPassword());
 
		return HashedPassword;
		
	}
	 
	public static boolean VerifyHash(String enteredPassword, String storedPasswordHash, String storedsalt)
	           throws NoSuchAlgorithmException, InvalidKeySpecException {
	     
		byte[] EnteredPasswordHash = null;
		byte[] StoredSalt = Base64.getDecoder().decode(storedsalt);
		byte[] StoredHash = Base64.getDecoder().decode(storedPasswordHash); 

 
		try {
			// Generate the hash of the entered password
			PBEKeySpec spec = new PBEKeySpec(enteredPassword.toCharArray(), StoredSalt, 65536, 128);
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			EnteredPasswordHash = skf.generateSecret(spec).getEncoded();
		}
		catch(Exception e) {
			System.out.println(e.toString());
		}
		// Compare the generated hash to the stored hash
		return Arrays.equals(EnteredPasswordHash, StoredHash); 
	}
}
